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

import dk.nsi.sdm4.core.util.Dates;
import dk.nsi.sdm4.sor.model.*;
import dk.nsi.sdm4.sor.xmlmodel.SpecialityMapper;
import dk.nsi.sdm4.sor.xmlmodel.UnitTypeMapper;
import org.apache.commons.io.FileUtils;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.util.Collection;

import static org.junit.Assert.*;


public class SorParserTest {
	public static File onePraksis;
	public static File oneSygehus;
	public static File oneApotek;

	public File getFile(String path) {
		return FileUtils.toFile(getClass().getClassLoader().getResource(path));
	}

	@Before
	public void setUp() {
		onePraksis = getFile("data/sor/ONE_PRAKSIS.xml");
		oneSygehus = getFile("data/sor/ONE_SYGEHUS.xml");
		oneApotek = getFile("data/sor/ONE_APOTEK.xml");
	}

	@Test
	public void testSinglePraksis() throws Exception {
		SORDataSets dataSets = SORImporter.parse(onePraksis);

		Collection<Praksis> praksis = dataSets.getPraksisDS().getEntities();
		Collection<Yder> yder = dataSets.getYderDS().getEntities();

		assertEquals(1, praksis.size());
		assertEquals(1, yder.size());

		Praksis p = praksis.iterator().next();

		assertEquals("Michael Filtenborg & co", p.getNavn());
		assertEquals(new Long(8331000016009L), p.getSorNummer());
		assertEquals(new Long(1084L), p.getRegionCode());
		assertEquals(SOREventHandler.parseXSDDate("1999-03-25"), p.getValidFrom());
		assertEquals(Dates.THE_END_OF_TIME, p.getValidTo());
		assertEquals(new Long(5790000141227L), p.getEanLokationsnummer());

		Yder y = yder.iterator().next();

		assertEquals("19062", y.getNummer());
		assertEquals(new Long(8341000016002L), y.getSorNummer());
		assertEquals(new Long(8331000016009L), y.getPraksisSorNummer());

		assertEquals("Michael Filtenborg", y.getNavn());
		assertEquals("Vesterbrogade 21", y.getVejnavn());
		assertEquals("3250", y.getPostnummer());
		assertEquals("Gilleleje", y.getBynavn());
		assertEquals("48300204", y.getTelefon());
		assertEquals(new Long(5790000141227L), y.getEanLokationsnummer());

		assertEquals(new Long(408443003L), y.getHovedSpecialeKode());
		assertEquals(SpecialityMapper.kodeToString(408443003L), y.getHovedSpecialeTekst());

		assertEquals(SOREventHandler.parseXSDDate("1999-03-25"), y.getValidFrom());
		assertEquals(Dates.THE_END_OF_TIME, y.getValidTo());
	}

	@Test
	public void testSingleSygehus() throws Exception {
		SORDataSets dataSets = SORImporter.parse(oneSygehus);

		Collection<Sygehus> sygehus = dataSets.getSygehusDS().getEntities();
		Collection<SygehusAfdeling> afdeling = dataSets.getSygehusAfdelingDS().getEntities();

		assertEquals(1, sygehus.size());

		Sygehus s = sygehus.iterator().next();

		assertNull(s.getEanLokationsnummer());
		assertEquals("2529", s.getNummer());
		assertEquals(new Long(347811000016004L), s.getSorNummer());

		assertEquals("Roskilde Øjenklinik", s.getNavn());
		assertEquals("Hestetorvet 8", s.getVejnavn());
		assertEquals("4000", s.getPostnummer());
		assertEquals("Roskilde", s.getBynavn());
		assertEquals("46361266", s.getTelefon());
		assertEquals("www.roskildeojenklinik.dk", s.getWww());
		assertEquals("J.Thulesen@dadlnet.dk", s.getEmail());

		assertEquals(SOREventHandler.parseXSDDate("2009-10-08"), s.getValidFrom());
		assertEquals(Dates.THE_END_OF_TIME, s.getValidTo());

		assertEquals(2, afdeling.size());

		SygehusAfdeling sa = dataSets.getSygehusAfdelingDS().getEntityById(347821000016008L);
		assertNotNull(sa);
		assertNull(sa.getEanLokationsnummer());
		assertEquals("252901", sa.getNummer());
		assertEquals(new Long(347821000016008L), sa.getSorNummer());
		assertEquals(new Long(347811000016004L), sa.getSygehusSorNummer());
		assertNull(sa.getOverAfdelingSorNummer());
		assertEquals(new Long(347811000016004L), sa.getUnderlagtSygehusSorNummer());

		assertEquals("Roskilde Øjenklinik, afdeling", sa.getNavn());
		assertEquals("Hestetorvet 8", sa.getVejnavn());
		assertEquals("4000", sa.getPostnummer());
		assertEquals("Roskilde", sa.getBynavn());
		assertEquals("46361266", sa.getTelefon());
		assertEquals("www.roskildeojenklinik.dk", sa.getWww());
		assertEquals("J.Thulesen@dadlnet.dk", sa.getEmail());

		assertEquals(new Long(550811000005108L), sa.getAfdelingTypeKode());
		assertEquals(UnitTypeMapper.kodeToString(550811000005108L), sa.getAfdelingTypeTekst());
		assertEquals(SOREventHandler.parseXSDDate("2009-10-07"), sa.getValidFrom());
		assertEquals(Dates.THE_END_OF_TIME, sa.getValidTo());

		sa = dataSets.getSygehusAfdelingDS().getEntityById(347831000016005L);
		assertNotNull(sa);
		assertNull(sa.getEanLokationsnummer());
		assertEquals("2529010", sa.getNummer());
		assertEquals(new Long(347831000016005L), sa.getSorNummer());
		assertNull(sa.getSygehusSorNummer());
		assertEquals(new Long(347821000016008L), sa.getOverAfdelingSorNummer());
		assertEquals(new Long(347811000016004L), sa.getUnderlagtSygehusSorNummer());

		assertEquals("Roskilde Øjenklinik, beh. afsnit", sa.getNavn());
		assertEquals("Hestetorvet 8", sa.getVejnavn());
		assertEquals("4000", sa.getPostnummer());
		assertEquals("Roskilde", sa.getBynavn());
		assertEquals("46361266", sa.getTelefon());
		assertEquals("www.roskildeojenklinik.dk", sa.getWww());
		assertEquals("J.Thulesen@dadlnet.dk", sa.getEmail());

		assertEquals(new Long(550851000005109L), sa.getAfdelingTypeKode());
		assertEquals(UnitTypeMapper.kodeToString(550851000005109L), sa.getAfdelingTypeTekst());
		assertEquals(new Long(394594003L), sa.getHovedSpecialeKode());
		assertEquals(SpecialityMapper.kodeToString(394594003L), sa.getHovedSpecialeTekst());

		assertEquals(SOREventHandler.parseXSDDate("2009-10-08"), sa.getValidFrom());
		assertEquals(Dates.THE_END_OF_TIME, sa.getValidTo());
	}

	@Test
	public void testSingleApotek() throws Exception {
		SORDataSets dataSets = SORImporter.parse(oneApotek);

		Collection<Apotek> apotek = dataSets.getApotekDS().getEntities();

		assertEquals(1, apotek.size());

		Apotek a = apotek.iterator().next();
		assertEquals(new Long(5790000173624L), a.getEanLokationsnummer());
		assertEquals(new Long(362L), a.getApotekNummer());
		assertEquals(new Long(1L), a.getFilialNummer());

		assertEquals("Værløse Apotek", a.getNavn());
		assertEquals("Bymidten 13", a.getVejnavn());
		assertEquals("3500", a.getPostnummer());
		assertEquals("Værløse", a.getBynavn());
		assertEquals("42482209", a.getTelefon());
		assertNull(a.getWww());
		assertNull(a.getEmail());

		assertEquals(SOREventHandler.parseXSDDate("1995-02-20"), a.getValidFrom());
		assertEquals(Dates.THE_END_OF_TIME, a.getValidTo());
	}
}
