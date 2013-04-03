/**
 * The MIT License
 *
 * Original work sponsored and donated by National Board of e-Health (NSI), Denmark
 * (http://www.nsi.dk)
 *
 * Copyright (C) 2011 National Board of e-Health (NSI), Denmark (http://www.nsi.dk)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package dk.nsi.sdm4.sor;

import dk.nsi.sdm4.sor.config.SorimporterApplicationConfig;
import dk.nsi.sdm4.testutils.TestDbConfiguration;
import org.apache.commons.io.FileUtils;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.TemporaryFolder;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.net.URL;
import java.sql.Timestamp;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
@ContextConfiguration(classes = {SorimporterApplicationConfig.class, TestDbConfiguration.class})
public class SORIntegrationTest {
	@Autowired
	JdbcTemplate jdbcTemplate;

	@Autowired
	SORImporter importer;

	@Rule
	public TemporaryFolder tmpDir = new TemporaryFolder();

	@Test
	public void testImport() throws Exception {
		importFile("data/sor/SOR_FULL.xml");

		assertDbCount(3148, "Praksis");
		assertDbCount(5434, "Yder");
		assertDbCount(469, "Sygehus");
		assertDbCount(2890, "SygehusAfdeling");
		assertDbCount(328, "Apotek");
		assertDbCount(49, "Praksis where ValidTo < now()");
		assertDbCount(451, "Yder where ValidTo < now()");
		assertDbCount(20, "Sygehus where ValidTo < now()");
		assertDbCount(255, "SygehusAfdeling where ValidTo < now()");
		assertDbCount(2, "Apotek where ValidTo < now()");
		assertDbCount(3148 - 49, "Praksis where ValidTo > now()");
		assertDbCount(5434 - 451, "Yder where ValidTo > now()");
		assertDbCount(469 - 20, "Sygehus where ValidTo > now()");
		assertDbCount(2890 - 255, "SygehusAfdeling where ValidTo > now()");
		assertDbCount(328 - 2, "Apotek where ValidTo > now()");
	}

    @Test
    public void modifiedDateIsUpdatedOnChange() throws Exception {
        importFile("data/sor/SOR_FULL.xml");
        Timestamp modified1 = jdbcTemplate.queryForObject(
                "SELECT ModifiedDate FROM Praksis ORDER BY ModifiedDate DESC LIMIT 1", Timestamp.class);
        Thread.sleep(1000);
        importFile("data/sor/SOR_FULL2.xml");
        Timestamp modified2 = jdbcTemplate.queryForObject(
                "SELECT ModifiedDate FROM Praksis ORDER BY ModifiedDate DESC LIMIT 1", Timestamp.class);
        assertFalse(modified1.equals(modified2));
    }

	private void assertDbCount(int expected, String table) {
		assertEquals(expected, jdbcTemplate.queryForInt("Select count(*) FROM "+ table));
	}

	private void importFile(String filePath) throws Exception {
		URL resource = getClass().getClassLoader().getResource(filePath);
		File datasetDir = tmpDir.newFolder();
		FileUtils.copyURLToFile(resource, new File(datasetDir, lastPathSegment(filePath)));

		importer.process(datasetDir);
	}

	private String lastPathSegment(String filePath) {
		String[] segments = filePath.split("/");

		return segments[segments.length - 1];
	}
}
