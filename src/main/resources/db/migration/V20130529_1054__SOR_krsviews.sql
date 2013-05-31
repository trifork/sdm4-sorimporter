
-- -----------------------------------------------------
-- Someone has to create the SKRS tables first time
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SKRSViewMapping` (
  `idSKRSViewMapping` BIGINT(15) NOT NULL AUTO_INCREMENT ,
  `register` VARCHAR(255) NOT NULL ,
  `datatype` VARCHAR(255) NOT NULL ,
  `version` INT NOT NULL ,
  `tableName` VARCHAR(255) NOT NULL ,
  `createdDate` TIMESTAMP NOT NULL ,
  PRIMARY KEY (`idSKRSViewMapping`) ,
  INDEX `idx` (`register` ASC, `datatype` ASC, `version` ASC) ,
  UNIQUE INDEX `unique` (`register` ASC, `datatype` ASC, `version` ASC) )
  ENGINE = InnoDB;
CREATE  TABLE IF NOT EXISTS `SKRSColumns` (
  `idSKRSColumns` BIGINT(15) NOT NULL AUTO_INCREMENT ,
  `viewMap` BIGINT(15) NOT NULL ,
  `isPID` TINYINT NOT NULL ,
  `tableColumnName` VARCHAR(255) NOT NULL ,
  `feedColumnName` VARCHAR(255) NULL ,
  `feedPosition` INT NOT NULL ,
  `dataType` INT NOT NULL ,
  `maxLength` INT NULL ,
  PRIMARY KEY (`idSKRSColumns`) ,
  INDEX `viewMap_idx` (`viewMap` ASC) ,
  UNIQUE INDEX `viewColumn` (`tableColumnName` ASC, `viewMap` ASC) ,
  CONSTRAINT `viewMap`
  FOREIGN KEY (`viewMap` )
  REFERENCES `SKRSViewMapping` (`idSKRSViewMapping` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;

-- ---------------------------------------------------------------------------------------------------------------------
-- SOR
-- ---------------------------------------------------------------------------------------------------------------------

INSERT IGNORE INTO SKRSViewMapping (register, datatype, version, tableName, createdDate) VALUES ('sor', 'apotek', 1, 'Apotek', NOW());
INSERT IGNORE INTO SKRSColumns (viewMap, isPID, tableColumnName, feedColumnName, feedPosition, dataType, maxLength) VALUES
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 1, 'ApotekPID',                           NULL, 0, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'SorNummer',                    'sorNummer', 1, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'ApotekNummer',              'apotekNummer', 2, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'FilialNummer',              'filialNummer', 3, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'EanLokationsnummer',  'eanLokationsnummer', 4, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'cvr',                                'cvr', 5, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'pcvr',                              'pcvr', 6, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'Navn',                              'navn', 7, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'Telefon',                        'telefon', 8, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'Vejnavn',                        'vejnavn', 9, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'Postnummer',                  'postnummer',10, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'Bynavn',                          'bynavn',11, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'Email',                            'email',12, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'Www',                                'www',13, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'ModifiedDate',                        NULL, 0, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'ValidFrom',                    'validFrom',14, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='apotek' AND version=1), 0, 'ValidTo',                        'validTo',15, 93, 12);

INSERT IGNORE INTO SKRSViewMapping (register, datatype, version, tableName, createdDate) VALUES ('sor', 'praksis', 1, 'Praksis', NOW());
INSERT IGNORE INTO SKRSColumns (viewMap, isPID, tableColumnName, feedColumnName, feedPosition, dataType, maxLength) VALUES
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 1, 'PraksisPID',                         NULL, 0, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 0, 'SorNummer',                   'sorNummer', 1, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 0, 'EanLokationsnummer', 'eanLokationsnummer', 2, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 0, 'RegionCode',                 'regionCode', 3, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 0, 'Navn',                             'navn', 4, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 0, 'ModifiedDate',                       NULL, 0, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 0, 'ValidFrom',                   'validFrom', 5, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='praksis' AND version=1), 0, 'ValidTo',                       'validTo', 6, 93, 12);

INSERT IGNORE INTO SKRSViewMapping (register, datatype, version, tableName, createdDate) VALUES ('sor', 'sygehus', 1, 'Sygehus', NOW());
INSERT IGNORE INTO SKRSColumns (viewMap, isPID, tableColumnName, feedColumnName, feedPosition, dataType, maxLength) VALUES
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 1, 'SygeHusPID',                         NULL, 0, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'SorNummer',                   'sorNummer', 1, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'EanLokationsnummer', 'eanLokationsnummer', 2, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Nummer',                         'nummer', 3, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Telefon',                       'telefon', 5, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Navn',                             'navn', 4, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Vejnavn',                       'vejnavn', 6, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Postnummer',                 'postnummer', 7, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Bynavn',                         'bynavn', 8, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Email',                           'email', 9, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'Www',                               'www',10, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'ModifiedDate',                       NULL, 0, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'ValidFrom',                   'validFrom',11, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehus' AND version=1), 0, 'ValidTo',                       'validTo',12, 93, 12);

INSERT IGNORE INTO SKRSViewMapping (register, datatype, version, tableName, createdDate) VALUES ('sor', 'sygehusafdeling', 1, 'SygehusAfdeling', NOW());
INSERT IGNORE INTO SKRSColumns (viewMap, isPID, tableColumnName, feedColumnName, feedPosition, dataType, maxLength) VALUES
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 1, 'SygeHusAfdelingPID',                               NULL, 0, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'SorNummer',                                 'sorNummer', 1, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'EanLokationsnummer',               'eanLokationsnummer', 5, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Nummer',                                       'nummer',10, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Navn',                                           'navn',11, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'SygehusSorNummer',                   'sygehusSorNummer', 2, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'OverAfdelingSorNummer',         'overafdelingSorNummer', 3, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'UnderlagtSygehusSorNummer', 'underlagtSygehusSorNummer', 4, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'AfdelingTypeKode',                   'afdelingTypeKode', 6, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'AfdelingTypeTekst',                 'afdelingTypeTekst', 7, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'HovedSpecialeKode',                 'hovedSpecialeKode', 8, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'HovedSpecialeTekst',               'hovedSpecialeTekst', 9, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Telefon',                                     'telefon',12, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Vejnavn',                                     'vejnavn',13, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Postnummer',                               'postnummer',14, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Bynavn',                                       'bynavn',15, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Email',                                         'email',16, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'Www',                                             'www',17, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'ModifiedDate',                                     NULL, 0, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'ValidFrom',                                 'validFrom',18, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='sygehusafdeling' AND version=1), 0, 'ValidTo',                                     'validTo',19, 93, 12);

INSERT IGNORE INTO SKRSViewMapping (register, datatype, version, tableName, createdDate) VALUES ('sor', 'yder', 1, 'Yder', NOW());
INSERT IGNORE INTO SKRSColumns (viewMap, isPID, tableColumnName, feedColumnName, feedPosition, dataType, maxLength) VALUES
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 1, 'YderPID',                            NULL, 0, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Nummer',                         'nummer', 4, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'SorNummer',                   'sorNummer', 1, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'PraksisSorNummer',     'praksisSorNummer', 2, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'EanLokationsnummer', 'eanLokationsnummer', 3, -5, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Telefon',                       'telefon', 6, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Navn',                             'navn', 5, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Vejnavn',                       'vejnavn', 7, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Postnummer',                 'postnummer', 8, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Bynavn',                         'bynavn', 9, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Email',                           'email',10, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'Www',                               'www',11, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'HovedSpecialeKode',   'hovedSpecialeKode',12, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'HovedSpecialeTekst', 'hovedSpecialeTekst',13, 12, NULL),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'ModifiedDate',                       NULL, 0, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'ValidFrom',                   'validFrom',14, 93, 12),
((SELECT idSKRSViewMapping FROM SKRSViewMapping WHERE register='sor' AND datatype='yder' AND version=1), 0, 'ValidTo',                       'validTo',15, 93, 12);
