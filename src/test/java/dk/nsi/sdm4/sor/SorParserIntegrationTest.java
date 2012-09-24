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

import dk.nsi.sdm4.sor.model.*;
import org.apache.commons.io.FileUtils;
import org.junit.Test;

import java.io.File;
import java.util.Collection;

import static org.junit.Assert.assertEquals;


public class SorParserIntegrationTest {
	@Test
	public void testFullTest() throws Exception {
		SORDataSets dataSets = SORImporter.parse(getFile("data/sor/SOR_FULL.xml"));

		Collection<Praksis> praksis = dataSets.getPraksisDS().getEntities();
		Collection<Yder> yder = dataSets.getYderDS().getEntities();
		Collection<Sygehus> sygehus = dataSets.getSygehusDS().getEntities();
		Collection<SygehusAfdeling> sygehusAfdeling = dataSets.getSygehusAfdelingDS().getEntities();
		Collection<Apotek> apotek = dataSets.getApotekDS().getEntities();

		assertEquals(3148, praksis.size());
		assertEquals(5434, yder.size());
		assertEquals(469, sygehus.size());
		assertEquals(2890, sygehusAfdeling.size());
		assertEquals(328, apotek.size());
	}

	@Test
	public void TestFull2Tests() throws Exception {
		SORDataSets dataSets = SORImporter.parse(getFile("data/sor/SOR_FULL2.xml"));

		Collection<Praksis> praksis = dataSets.getPraksisDS().getEntities();
		Collection<Yder> yder = dataSets.getYderDS().getEntities();
		Collection<Sygehus> sygehus = dataSets.getSygehusDS().getEntities();
		Collection<SygehusAfdeling> sygehusAfdeling = dataSets.getSygehusAfdelingDS().getEntities();
		Collection<Apotek> apotek = dataSets.getApotekDS().getEntities();

		assertEquals(3159, praksis.size());
		assertEquals(5456, yder.size());
		assertEquals(475, sygehus.size());
		assertEquals(2922, sygehusAfdeling.size());
		assertEquals(329, apotek.size());
	}

	private File getFile(String path) {
		return FileUtils.toFile(getClass().getClassLoader().getResource(path));
	}
}
