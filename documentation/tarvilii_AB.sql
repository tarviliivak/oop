-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Loomise aeg: Veebr 05, 2018 kell 11:18 EL
-- Serveri versioon: 5.6.38
-- PHP versioon: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `tarvilii_AB`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`tarviliivak`@`localhost` PROCEDURE `esimeneprotseduur` ()  BEGIN
SELECT L_nimi AS 'Lapsed' FROM Synnid
WHERE synnikaal < 3000
GROUP BY L_nimi;
END$$

CREATE DEFINER=`tarviliivak`@`localhost` PROCEDURE `gruppconcat` ()  BEGIN
SELECT 
Emad.Ema_nimi,GROUP_CONCAT(L_nimi)
FROM Synnid INNER JOIN Emad ON Emad.Ema_id=Synnid.Ema_id GROUP BY Synnid.Ema_id;
END$$

CREATE DEFINER=`tarviliivak`@`localhost` PROCEDURE `lisamine` (IN `Ema_id` VARCHAR(2), IN `L_nimi` VARCHAR(9), IN `Synniaeg` VARCHAR(5), IN `Elukoht` VARCHAR(10), IN `Synnikaal` VARCHAR(4), IN `Synnipikkus` VARCHAR(2), IN `Sugu` VARCHAR(1), IN `Synnikuupaev` VARCHAR(10))  BEGIN
INSERT INTO Synnid(Ema_id, L_nimi, Synniaeg, Elukoht, Synnikaal, Synnipikkus, Sugu, Synnikuupaev)
VALUES
(Ema_id, L_nimi, Synniaeg, Elukoht, Synnikaal, Synnipikkus, Sugu, Synnikuupaev);
END$$

CREATE DEFINER=`tarviliivak`@`localhost` PROCEDURE `lisa_lapsi` (`in_date` VARCHAR(10), `in_Ema_nimi` VARCHAR(50), `in_L_nimi` VARCHAR(9), `in_Elukoht` VARCHAR(10), `in_Synniaeg` VARCHAR(5), `in_Synnikaal` INT(4), `in_Synnpikkus` INT(2), `in_Sugu` VARCHAR(1), OUT `error` VARCHAR(50))  MODIFIES SQL DATA
BEGIN
DECLARE loendur INT DEFAULT 0;  
SELECT COUNT(*) INTO loendur FROM Emad WHERE Ema_nimi = in_Ema_nimi;

IF !loendur THEN 
SET error = 'Sellist ema ei ole tabelis';
ELSE
INSERT INTO Synnid
(Synnikuupaev, Ema_id,L_nimi,Elukoht,Synniaeg,Synnikaal,Synnipikkus,Sugu) 
VALUES 
(in_date,
(SELECT Ema_id FROM Emad WHERE Ema_nimi=in_Ema_nimi),
in_L_nimi,in_Elukoht,in_Synniaeg,in_Synnikaal,in_Synnipikkus,in_Sugu);
END IF;
END$$

CREATE DEFINER=`tarviliivak`@`localhost` PROCEDURE `valjasta` ()  BEGIN
SELECT L_nimi, Synnikaal FROM Synnid;
END$$

--
-- Funktsioonid
--
CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `kaalud` (`Synnikaal` VARCHAR(4)) RETURNS VARCHAR(4) CHARSET latin1 RETURN Synnikaal/1000$$

CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `kuupaev` (`Synnikuupaev` VARCHAR(10)) RETURNS VARCHAR(10) CHARSET latin1 RETURN date_format(Synnikuupaev,'%d.%m.%Y')$$

CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `minufunktsioon` (`Hind` DECIMAL(10,2)) RETURNS DECIMAL(10,1) BEGIN
RETURN ROUND(Hind,1);
END$$

CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `proovifunktsioon` (`item_sum` DECIMAL(10,2)) RETURNS DECIMAL(10,1) BEGIN
RETURN ROUND(item_sum,1);
END$$

CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `sada` (`Hind` FLOAT(6,2)) RETURNS FLOAT(6,2) RETURN Hind * 100$$

CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `telnumber1` (`Telefon` VARCHAR(15)) RETURNS VARCHAR(15) CHARSET latin1 RETURN CONCAT('+372', Telefon)$$

CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `ümardamine` (`i` DECIMAL(10,3)) RETURNS DECIMAL(10,2) RETURN i$$

CREATE DEFINER=`tarviliivak`@`localhost` FUNCTION `vanus` (`Synnikuupaev` VARCHAR(10)) RETURNS VARCHAR(10) CHARSET latin1 RETURN TIMESTAMPDIFF(YEAR,Synnikuupaev,CURDATE())$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `AINE`
--

CREATE TABLE `AINE` (
  `a_kood` int(4) NOT NULL,
  `nimetus` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

--
-- Andmete tõmmistamine tabelile `AINE`
--

INSERT INTO `AINE` (`a_kood`, `nimetus`) VALUES
(1, 'Kutsealane inglise keel'),
(2, 'Adobe Illustratori kasutamine'),
(3, 'Adobe Photoshopi kasutamine'),
(4, 'Aedvilja ttlemise tehn.'),
(5, 'Aedvilja ttlemise tehnoloogia'),
(6, 'Ajalugu'),
(7, 'Alternatiivsed kontoritpaketid'),
(8, 'Andmebaasid'),
(9, 'Andmebaaside alused'),
(10, 'Andmebaaside projekteerimine'),
(11, 'Andmebaaside projekteerimine ja haldus'),
(12, 'Andmeturbe alused'),
(13, 'Andmeturve'),
(14, 'Andmettlus ja statistika'),
(15, 'Arhiivinduse alused'),
(16, 'Arvutipetus'),
(17, 'Asjaajamine'),
(18, 'Asjaajamisse alused'),
(19, 'Avalik esinemine'),
(20, 'Baarit'),
(21, 'Betoonitd'),
(22, 'Bioloogia'),
(23, 'Catering'),
(24, 'CCNA1-arvutivrkude alused'),
(25, 'CCNA2-ruuterite ja marsruutimise alused'),
(26, 'CCNA3-Kommunikatsiooni alused ja marsruutimine'),
(27, 'CCNA4-Laivrgu tehnoloogiad'),
(28, 'Dekoratiivviimistlus-tehnikad'),
(29, 'Dieettoitlustamine'),
(30, 'Dokumendi- ja arhiivihaldus'),
(31, 'Dokumendihalduspraktika'),
(32, 'Eelarveline raamatupidamine'),
(33, 'Eesti keel'),
(34, 'Eesti maastikud'),
(35, 'Eesti rekreatsioonigeograafia'),
(36, 'Eesti turismigeograafia'),
(37, 'Eesti kossteemid'),
(38, 'Eetika alused'),
(39, 'Ehitamise alused'),
(40, 'Ehitamise phialused'),
(41, 'Ehitiste konstruktsioonid'),
(42, 'Ehituse alused'),
(43, 'Ehituskonstruktsioonid'),
(44, 'Ehitusmdistamine'),
(45, 'Ehitusmdistamine ja mrkimine'),
(46, 'Ehitusrenoveerimise alused'),
(47, 'Ehitustriistad ja pinnattlus'),
(48, 'e-kaubandus'),
(49, 'Eksam'),
(50, 'Eksamid, kursusetd'),
(51, 'EL majandus ja tturg'),
(52, 'Elektripetus'),
(53, 'Elektroonika alused'),
(54, 'Elektrotehnika'),
(55, 'Elektrotehnika ja automaatika elemendid'),
(56, 'Enesearengu kursus'),
(57, 'Enesevljendus'),
(58, 'Eriala toetav eesti keel'),
(59, 'Eriala toetav inglise keel'),
(60, 'Eriala toetav keh.kasv'),
(61, 'Eriala toetav saksa keel'),
(62, 'Eritoitumine'),
(63, 'Esitluse loomine'),
(64, 'Esitlusgraafika ja multimeedia'),
(65, 'Esmaabi'),
(66, 'e-teenused'),
(67, 'Etikett'),
(68, 'Ettevtlus ja turundus'),
(69, 'Ettevtluse alused'),
(70, 'Ettevttepraktika'),
(71, 'EUCIPi eksamiks valmistumine'),
(72, 'Euroopa turismigeograafia'),
(73, 'Failihaldus'),
(74, 'Finantsanals'),
(75, 'Finantsraamatupidamine'),
(76, 'Finantsraamatupidamine arvutil'),
(77, 'Finantsvahendus'),
(78, 'Fsika');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `AINE_OPILANE`
--

CREATE TABLE `AINE_OPILANE` (
  `aine_kood` int(4) DEFAULT NULL,
  `o_isikukood` char(11) COLLATE utf8_estonian_ci DEFAULT NULL,
  `opetaja_kood` char(11) COLLATE utf8_estonian_ci DEFAULT NULL,
  `hinne` varchar(1) COLLATE utf8_estonian_ci DEFAULT NULL,
  `kuupaev` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

--
-- Andmete tõmmistamine tabelile `AINE_OPILANE`
--

INSERT INTO `AINE_OPILANE` (`aine_kood`, `o_isikukood`, `opetaja_kood`, `hinne`, `kuupaev`) VALUES
(4, '48810242787', '47004122783', '3', '2007-03-05'),
(5, '38810222497', '37909122763', '4', '2007-03-05'),
(6, '38712062497', '47001222783', '4', '2007-03-05'),
(7, '38911212491', '47304122782', '5', '2007-03-05'),
(8, '38806062494', '46604122785', '5', '2007-03-05'),
(9, '39006022497', '35612122733', '5', '2007-03-05'),
(10, '49010262577', '37709092783', '5', '2007-03-05'),
(11, '48910222497', '47810122783', '5', '2007-03-05'),
(12, '49112162497', '47309092783', '3', '2007-03-05'),
(13, '49012292493', '46103122783', '3', '2007-03-05'),
(14, '48910212197', '45903032783', '3', '2007-01-16'),
(15, '38811202495', '37112042785', '3', '2007-01-16'),
(16, '38710022497', '38011082783', '5', '2007-01-16'),
(17, '39212262427', '47001012783', '5', '2007-01-16'),
(18, '38904292497', '45008122783', '5', '2007-01-16'),
(19, '49111162497', '47002122783', '3', '2007-01-16'),
(20, '38809262497', '36902022783', '4', '2007-01-16'),
(21, '49107232497', '47004122737', '4', '2007-01-16'),
(22, '38911222492', '37405122789', '4', '2007-01-16'),
(23, '49009162497', '45510042783', '4', '2007-01-16'),
(24, '39112312497', '47012042686', '5', '2007-01-16'),
(25, '48901312397', '35104042783', '4', '2007-01-16'),
(26, '38910262497', '45806112783', '3', '2007-01-16'),
(27, '49011292497', '47111122781', '4', '2007-01-16');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `content`
--

CREATE TABLE `content` (
  `content_id` bigint(20) UNSIGNED NOT NULL,
  `content` text COLLATE latin1_general_ci NOT NULL,
  `clean_content` text COLLATE latin1_general_ci NOT NULL,
  `title` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `show_in_menu` tinyint(1) NOT NULL DEFAULT '0',
  `sort` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created` datetime NOT NULL,
  `is_first_page` tinyint(1) NOT NULL DEFAULT '0',
  `lang_id` varchar(2) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `Emad`
--

CREATE TABLE `Emad` (
  `Ema_id` int(2) DEFAULT NULL,
  `Ema_nimi` varchar(11) DEFAULT NULL,
  `Vanus` int(2) DEFAULT NULL,
  `Laste_arv` int(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Andmete tõmmistamine tabelile `Emad`
--

INSERT INTO `Emad` (`Ema_id`, `Ema_nimi`, `Vanus`, `Laste_arv`) VALUES
(1, 'Imbi', 21, 1),
(2, 'Rapunzel', 26, 2),
(3, 'Katariina', 30, 1),
(4, 'Kristall', 29, 1),
(5, 'Kurr', 28, 1),
(6, 'Miili', 28, 1),
(7, 'Patsike', 31, 3),
(8, 'Lilleke', 22, 3),
(9, 'Margareth', 32, 2),
(10, 'Kiki', 22, 1),
(11, 'Katriin', 28, 2),
(12, 'Zipsik', 29, 1),
(13, 'Signeke', 25, 1),
(14, 'Eveke', 26, 2),
(15, 'Nadja', 27, 2),
(16, 'Moonika', 24, 1),
(17, 'Plikake', 23, 1),
(18, 'Kristlin', 21, 1),
(19, 'Zandra', 20, 1),
(20, 'Pisikeingel', 24, 1),
(21, 'Jessika', 27, 1),
(22, 'Kriste', 28, 3),
(23, 'Triinu', 27, 2),
(24, 'Kiisuke', 20, 1),
(25, 'Ade', 34, 2),
(26, 'Mormela', 20, 2),
(27, 'Krista', 24, 2),
(28, 'Carmen', 30, 2),
(29, 'Silja', 22, 1),
(30, 'Viivi', 31, 1),
(31, 'Liisa-Lota', 26, 1),
(32, 'Margariita', 24, 2),
(33, 'Annika', 27, 1),
(34, 'Piibe', 28, 2),
(35, 'Nella', 28, 2),
(36, 'Fly', 24, 2),
(37, 'Blanka', 24, 1),
(38, 'Roosi', 29, 2),
(39, 'Ave', 29, 3),
(40, 'Mari', 25, 1),
(41, 'Kirke', 19, 1),
(42, 'Marja', 32, 1),
(43, 'Tups', 30, 1),
(44, 'Kiisu', 19, 1),
(45, 'Merka', 20, 1),
(46, 'Pille', 26, 1),
(47, 'Maiki', 26, 1),
(48, 'Lilleke', 27, 2),
(49, 'Viki', 30, 2),
(50, 'Katrin', 29, 2);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `Keskmine`
--

CREATE TABLE `Keskmine` (
  `Kuupäev` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Keskmine_Hind` float(6,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `Keskmine`
--

INSERT INTO `Keskmine` (`Kuupäev`, `Keskmine_Hind`) VALUES
('2017-11-13 15:30:29', 122.88),
('2017-11-21 12:54:18', 255.65),
('2017-11-21 13:00:41', 269.96),
('2017-11-21 13:03:35', 255.65);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `KLIENDID`
--

CREATE TABLE `KLIENDID` (
  `Kliendi_id` int(10) UNSIGNED NOT NULL,
  `Kliendi_nimi` varchar(60) NOT NULL,
  `Boonuspunktid` int(11) DEFAULT '0',
  `Soodusprotsent` int(11) DEFAULT '5'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `KLIENDID`
--

INSERT INTO `KLIENDID` (`Kliendi_id`, `Kliendi_nimi`, `Boonuspunktid`, `Soodusprotsent`) VALUES
(1, 'Juss Julla', 3000, 5),
(2, 'Kalle Kala', 2500, 5),
(3, 'Kalle-Pelle Iiripubi', 2499, 5),
(4, 'Koit Haavatud Seal Figaro Siin', 2601, 5),
(7, 'Mari Maasikas', 1200, 5),
(8, 'Vinni Veni', 498, 5),
(9, 'Ats Aasakese', 1001, 5),
(11, 'Volli Vupsti', 2002, 5);

--
-- Päästikud `KLIENDID`
--
DELIMITER $$
CREATE TRIGGER `boonus` AFTER UPDATE ON `KLIENDID` FOR EACH ROW BEGIN
IF 5+(floor(NEW.boonuspunktid/500)*5)>25 THEN
INSERT INTO K_logi (Kliendi_id, kuupaev, boonuspunktide_arv, soodusprotsent) VALUES (NEW.Kliendi_id, now(), NEW.Boonuspunktid, NEW.soodusprotsent, 25);
ELSE
INSERT INTO K_logi(Kliendi_id, kuupaev, boonuspunktide_arv,soodusprotsent) VALUES (NEW.Kliendi_id, now(), NEW.Boonuspunktid,
(5+(floor(NEW.boonuspunktid/500)*5)));                         END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `K_logi`
--

CREATE TABLE `K_logi` (
  `ID` int(10) UNSIGNED NOT NULL,
  `Kliendi_id` int(10) UNSIGNED NOT NULL,
  `kuupaev` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `boonuspunktide_arv` int(11) NOT NULL DEFAULT '0',
  `soodusprotsent` int(11) NOT NULL DEFAULT '5'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `K_logi`
--

INSERT INTO `K_logi` (`ID`, `Kliendi_id`, `kuupaev`, `boonuspunktide_arv`, `soodusprotsent`) VALUES
(25, 8, '2017-12-05 18:11:21', 1601, 20),
(29, 3, '2017-12-05 18:19:50', 2499, 25),
(28, 8, '2017-12-05 18:19:24', 498, 5),
(27, 11, '2017-12-05 18:17:29', 2002, 25),
(26, 2, '2017-12-05 18:14:30', 1002, 15),
(24, 7, '2017-12-05 18:08:11', 1200, 15);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `LAENUTAMINE`
--

CREATE TABLE `LAENUTAMINE` (
  `Raamatu_id` int(10) UNSIGNED NOT NULL,
  `Lugeja_id` int(10) UNSIGNED NOT NULL,
  `Kuupaev` date NOT NULL,
  `Tahtaeg` date NOT NULL,
  `Tagastamine` date DEFAULT NULL,
  `Laenutamise_id` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `LAENUTAMINE`
--

INSERT INTO `LAENUTAMINE` (`Raamatu_id`, `Lugeja_id`, `Kuupaev`, `Tahtaeg`, `Tagastamine`, `Laenutamise_id`) VALUES
(4, 5, '2017-09-03', '2017-09-24', '2017-11-12', 1),
(13, 12, '2017-10-03', '2017-10-24', '2017-10-10', 2),
(31, 7, '2017-09-29', '2017-10-04', '2017-10-13', 3),
(5, 11, '2017-10-03', '2017-10-12', '2017-10-01', 4),
(31, 9, '2017-10-01', '2017-10-22', '2017-10-09', 5),
(25, 11, '2017-08-01', '2017-08-22', '0000-00-00', 6),
(24, 8, '2017-10-01', '2017-10-22', '2017-12-12', 7),
(5, 11, '2017-10-01', '2017-10-22', NULL, 8),
(30, 9, '2017-10-01', '2017-10-22', NULL, 9);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `LUGEJA`
--

CREATE TABLE `LUGEJA` (
  `Lugeja_id` int(10) UNSIGNED NOT NULL,
  `Eesnimi` varchar(50) NOT NULL,
  `Perenimi` varchar(50) NOT NULL,
  `Isikukood` char(11) NOT NULL,
  `Aadress` varchar(100) DEFAULT NULL,
  `Telefon` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Amet` varchar(50) DEFAULT NULL,
  `Asutus` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `LUGEJA`
--

INSERT INTO `LUGEJA` (`Lugeja_id`, `Eesnimi`, `Perenimi`, `Isikukood`, `Aadress`, `Telefon`, `Email`, `Amet`, `Asutus`) VALUES
(44, '', '', '', NULL, NULL, NULL, NULL, NULL),
(5, 'Kalle', 'Kohin', '38910262497', 'Tartu Pärna 23-12', '56789576', 'kalle12@hot.ee', 'õpilane', 'Tartu KHK'),
(6, 'Tiia', '	Tuisk', '49011292497', 'Tartu Riia 126', '50468977', 'tiia.tuisk@hotmail.com', 'õpetaja', 'Meie kool'),
(7, 'Pille', 'Pill', '49110302488', 'Tartu Jalaka 12-3', '51689789', 'pillekas@gmail.com', 'õpilane', 'Meie kool'),
(8, 'Kati', '	Kask', '49010162558', 'Tartu Kopli 1', '53459878', 'kati_k@kool.ee', 'juhiabi', 'AS Töö'),
(9, 'Malle', 'Moos', '48910012697', 'Tartu Võru 54-21', '56423789', '', 'koristaja', 'Oü Kord ja Puhtus'),
(10, 'Mari', '	Maasikas', '48810242787', 'Tartu Aida 3-14', '50458977', '', '', ''),
(11, 'Joosep', 'Jalakas', '38810222497', 'Tartu ', '556457575', 'joosepjalakas@ut.ee', 'lektor', 'Tartu ülikool'),
(12, 'Tiit', '	Tikk', '38712062497', 'Tartu', '547799133', 'tiit.tikk@astiit.ee', 'juhataja', 'As Tiit'),
(13, 'Ragnar', 'Roos', '38911212491', 'Tartu', '7715478', 'rax_x@gmail.com', 'õpilane', 'Uus kool'),
(14, 'Robert', 'Rohi', '38806062494', 'Tartu Võru 36', '588787362', 'robi@uuuskool.ee', 'õpetaja', 'Uus kool'),
(15, 'Kevin', 'Kivi', '39006022497', 'Tartu Turu 5-12', '59791547', 'kivi@hot.ee', 'õpilane', 'Uus kool'),
(16, 'Sille', 'Siil', '49010262577', 'Tartu Võru 69', '454667993', 'siilike@udus.ee', 'üliõpilane', 'Tartu ülikool'),
(17, 'Lilli', 'Lill', '48910222497', 'Tartu Pärna 34', '487541247', 'lilli.lill@kodu.ee', 'kodune', ''),
(18, 'Luisa', 'Tuul', '49112162497', 'Tartu Vanemuise 56-23', '558787887', 'tuul@puhub.ee', '', ''),
(19, 'Sandra', 'Saar', '49012292493', 'Tartu Narva mnt 34-12', '589456534', '', '', ''),
(20, 'Kadri', 'Kade', '48910212197', 'Tartu Võru 89', '', 'kati@kokk.ee', 'kokk', 'AS Söök ja jook'),
(21, 'Vaiko', 'Kook', '38811202495', 'Tartu Pikk 56-10', '7689898', '', 'autojuht', 'Oüauto'),
(22, 'Veiko', 'Vesi', '38710022497', 'Tartu Lai 76-11', '5877693', 'veiko@vesi.com', '', ''),
(23, 'Hannes', 'Hein', '39212262427', 'Tartu Betooni 24', '', 'heina@tool.ee', 'müüja', 'AS Tool'),
(24, 'Leo', 'Loots', '38904292497', 'Tartu Pepleri 2-1', '569873223', 'loots@maja.ee', 'autojuht', 'AS Maja'),
(25, 'Liia', 'Lips', '49111162497', 'Tartu Pärna 6', '69876222', 'lipsik@lk.ee', 'müüja', 'Riidepood'),
(26, 'Kalev', 'Komm', '38809262497', 'Tartu Võru 33', '5464645747', 'kalevikomm@komm.com', 'müüja', 'Kommipood'),
(27, 'Rita', 'Rehv', '49107232497', 'Tartu Riia 120', '52323424', 'rita.rehv@rehvivah.ee', 'kassapidaja', 'Rehvivahetus'),
(28, 'Janek', 'Jooksik', '38911222492', 'Tartu Raatuse 22-4', '56787900', 'janek@hot.ee', 'õpilane', 'Meie kool'),
(29, 'Jane', 'Jänes', '49009162497', 'Tartu Piima 12', '5424324325', 'jane321@hot.ee', 'õpilane', 'Teie kool'),
(30, 'Mart', 'Karu', '39112312497', 'Tartu Aleksandri 3-2', '587979797', 'mart.karu@teiekool.ee', 'õpetaja', 'Teie kool'),
(31, 'Kati', 'Karu', '48901312397', 'Tartu Jalaka 23-3', '74645679', 'kati.karu@teiekool.ee', 'õpilane', 'Teie kool'),
(32, '', '', '', NULL, NULL, NULL, NULL, NULL),
(33, '', '', '', NULL, NULL, NULL, NULL, NULL),
(34, 'Tarvi', 'Liivak', '39710256817', 'Tartu A.Haava 5-3', '5014239', 'tarviliivak@gmail.com', 'õpilane', 'Tartu KHK'),
(35, '', '', '', NULL, NULL, NULL, NULL, NULL),
(36, '', '', '', NULL, NULL, NULL, NULL, NULL),
(37, '', '', '', NULL, NULL, NULL, NULL, NULL),
(38, '', '', '', NULL, NULL, NULL, NULL, NULL),
(39, '', '', '', NULL, NULL, NULL, NULL, NULL),
(40, '', '', '', NULL, NULL, NULL, NULL, NULL),
(41, 'Joosep', 'Sinine', '50101013462', 'Tartu Tähe 43-1', NULL, NULL, NULL, NULL),
(42, '', '', '', NULL, NULL, NULL, NULL, NULL),
(43, 'Berit', 'Roosa', '60211132136', 'Tartu Küüni 23-11', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `OPETAJA`
--

CREATE TABLE `OPETAJA` (
  `opetaja_isikuk` char(11) COLLATE utf8_estonian_ci NOT NULL DEFAULT '',
  `eesnimi` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `perenimi` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `juhend_grupp` int(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

--
-- Andmete tõmmistamine tabelile `OPETAJA`
--

INSERT INTO `OPETAJA` (`opetaja_isikuk`, `eesnimi`, `perenimi`, `juhend_grupp`) VALUES
('47004122783', 'Olga', 'Kask', NULL),
('37909122763', 'Oliver', 'Kuusk', NULL),
('47001222783', 'Pille', 'Katus', NULL),
('47304122782', 'Piret', 'Siil', NULL),
('46604122785', 'Piret', 'Karu', NULL),
('35612122733', 'Priit', 'Rebane', NULL),
('37709092783', 'Priit', 'Jnes', NULL),
('47810122783', 'Sirje', 'Koer', NULL),
('47309092783', 'Sirje', 'Kass', NULL),
('46103122783', 'Sirje', 'Rebane', NULL),
('37112042785', 'Tarmo', 'Saar', NULL),
('38011082783', 'Tauno', 'Kuusik', NULL),
('45008122783', 'Thea', 'Tammik', NULL),
('47002122783', 'Tiina', 'Lilleaed', NULL),
('36902022783', 'Tiit', 'Lilleaed', NULL),
('37405122789', 'Toomas', 'Leht', NULL),
('45510042783', 'Triin', 'Oks', NULL),
('47012042686', 'Tuuliki', 'Kadaks', NULL),
('35104042783', 'Urmas', 'Okas', NULL),
('45806112783', 'Viia', 'Mgi', NULL),
('47111122781', 'Vilve', 'Org', NULL),
('45501042783', 'lle', 'Jgi', NULL),
('47304102783', 'Aime', 'Niit', NULL),
('47701042283', 'Aina', 'Jrv', NULL),
('46511252783', 'Aino', 'Oja', NULL),
('45109182783', 'Aita', 'Vihm', NULL),
('36308232783', 'Aivar', 'Tuul', NULL),
('37305122789', 'Aivar', 'Rand', NULL),
('37504302683', 'Aivar', 'Kastan', NULL),
('47612312783', 'Aivi', 'Prn', NULL),
('47011112278', 'Anne', 'Kuusik', NULL),
('36506242583', 'Ilmar', 'Kuusemets', NULL),
('37204022787', 'Imre', 'Juhe', NULL),
('37909122583', 'Indrek', 'Traat', NULL),
('37308142783', 'Juhan', 'Juurikas', NULL),
('45903032783', 'Sirje', 'Mnd', 1),
('47001012783', 'Terje', 'Tamm', 2),
('47004122737', 'Tiiu', 'Rohi', 3),
('47210282884', 'Aile', 'Aas', 4),
('37107072773', 'Andrus', 'Kaasik', 5);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `OPILANE`
--

CREATE TABLE `OPILANE` (
  `isikukood` char(11) COLLATE utf8_estonian_ci NOT NULL DEFAULT '',
  `eesnimi` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `perenimi` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `sugu` varchar(1) COLLATE utf8_estonian_ci DEFAULT NULL,
  `o_aadress` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `k_aadress` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `telefon` int(20) DEFAULT NULL,
  `g_kood` int(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

--
-- Andmete tõmmistamine tabelile `OPILANE`
--

INSERT INTO `OPILANE` (`isikukood`, `eesnimi`, `perenimi`, `sugu`, `o_aadress`, `k_aadress`, `telefon`, `g_kood`) VALUES
('38910262497', 'Kalle', 'Kohin', 'm', 'Tartu', 'Tartu', 50789456, 1),
('49011292497', 'Tiia', 'Tuisk', 'n', 'Tartu', 'Tallinn', 0, 2),
('49110362488', 'Pille', 'Pill', 'n', 'Tartu', 'Prnu', 0, 3),
('49010162558', 'Kati', 'Kask', 'n', 'Tartu', 'Vru', 0, 4),
('48910012697', 'Malle', 'Moos', 'n', 'Tartu', 'Otep', 0, 5),
('48810242787', 'Mari', 'Maasikas', 'n', 'Tartu', 'Rngu', 0, 1),
('38810222497', 'Joosep', 'Jalakas', 'm', 'Tartu', 'Tartu', 0, 2),
('38712062497', 'Tiit', 'Tikk', 'm', 'Tartu', 'Plva', 0, 3),
('38911212491', 'Ragnar', 'Roos', 'm', 'Tartu', 'Prnu', 0, 4),
('38806062494', 'Robert', 'Rohi', 'm', 'Tartu', 'Vru', 0, 5),
('39006022497', 'Kevin', 'Kivi', 'm', 'Tartu', 'Otep', 0, 1),
('49010262577', 'Sille', 'Siil', 'n', 'Tartu', 'Rngu', 0, 2),
('48910222497', 'Lilli', 'Lill', 'n', 'Tartu', 'Tartu', 0, 2),
('49112162497', 'Luisa', 'Tuul', 'n', 'Tartu', 'Valga', 0, 3),
('49012292493', 'Sandra', 'Saar', 'n', 'Tartu', 'Prnu', 0, 3),
('48910212197', 'Kadri', 'Kade', 'n', 'Tartu', 'Vru', 0, 4),
('38811202495', 'Vaiko', 'Kook', 'm', 'Tartu', 'Otep', 0, 5),
('38710022497', 'Veiko', 'Vesi', 'm', 'Tartu', 'Rngu', 0, 1),
('39212262427', 'Hannes', 'Hein', 'm', 'Tartu', 'Tartu', 0, 1),
('38904292497', 'Leo', 'Loots', 'm', 'Tartu', 'Plva', 0, 5),
('49111162497', 'Liia', 'Lips', 'n', 'Tartu', 'Prnu', 0, 2),
('38809262497', 'Kalev', 'Komm', 'm', 'Tartu', 'Vru', 0, 2),
('49107232497', 'Rita', 'Rehv', 'n', 'Tartu', 'Otep', 0, 2),
('38911222492', 'Janek', 'Jooksik', 'm', 'Tartu', 'Rngu', 0, 3),
('49009162497', 'Jane', 'Jnes', 'n', 'Tartu', 'Tartu', 0, 4),
('39112312497', 'Mart', 'Karu', 'm', 'Tartu', 'Plva', 0, 5),
('48901312397', 'Kati', 'Karummm', 'n', 'Tartu', 'Prnu', 0, 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `OSAKOND`
--

CREATE TABLE `OSAKOND` (
  `o_kood` int(3) NOT NULL,
  `nimi` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `juhataja` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

--
-- Andmete tõmmistamine tabelile `OSAKOND`
--

INSERT INTO `OSAKOND` (`o_kood`, `nimi`, `juhataja`) VALUES
(1, 'IKT', 'Reet Arvuti'),
(2, 'Toitlustamine', 'Juta Kk'),
(3, 'Hotellimajandus', 'Tiia Maja'),
(4, 'Puit', 'Kalle Kapp');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `O_GRUPP`
--

CREATE TABLE `O_GRUPP` (
  `o_gr_kood` int(4) NOT NULL,
  `o_gr_nimi` varchar(20) COLLATE utf8_estonian_ci DEFAULT NULL,
  `nimi` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `eriala` varchar(100) COLLATE utf8_estonian_ci DEFAULT NULL,
  `o_kood` int(3) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_estonian_ci;

--
-- Andmete tõmmistamine tabelile `O_GRUPP`
--

INSERT INTO `O_GRUPP` (`o_gr_kood`, `o_gr_nimi`, `nimi`, `eriala`, `o_kood`) VALUES
(1, 'ARV07', 'Arvutiteenindus', 'IKT', 1),
(2, 'KKK06', 'Kokk', 'KOK', 2),
(3, 'RMT07', 'Raamatupidamine', 'IKT', 1),
(4, 'HTL05', 'Hotellindus', 'HOT', 3),
(5, 'TSL05', 'Tisler', 'PUIT', 4),
(6, 'VS17', 'Noorem tarkvaraarendaja', 'IKT', 1);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `RAAMAT`
--

CREATE TABLE `RAAMAT` (
  `Raamatu_id` int(10) UNSIGNED NOT NULL,
  `Pealkiri` varchar(150) NOT NULL,
  `Autor` varchar(100) DEFAULT NULL,
  `Aasta` year(4) DEFAULT NULL,
  `Valjaandja` varchar(150) DEFAULT NULL,
  `LK_arv` int(11) DEFAULT NULL,
  `Keel` varchar(50) NOT NULL,
  `Hind` float(6,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Andmete tõmmistamine tabelile `RAAMAT`
--

INSERT INTO `RAAMAT` (`Raamatu_id`, `Pealkiri`, `Autor`, `Aasta`, `Valjaandja`, `LK_arv`, `Keel`, `Hind`) VALUES
(4, 'Asum', 'Isaac Asimov', 1976, 'Eesti kirjastus', 193, 'eesti', 35.00),
(5, 'Ajaseemned', 'Isaac Asimov', 1978, 'Eesti kirjastus', 258, 'eesti', 38.00),
(6, 'Frankestein', 'Mary Shelly', 1968, 'Eesti kirjastus', 189, 'eesti', 29.00),
(7, 'T?de ja ?igus', 'A.H.Tammsaare', 1920, 'Tallinn', 459, 'eesti', 235.00),
(8, 'Kevade', 'Oskar Luts', 1945, 'Tallinn', 268, 'eesti', 46.00),
(9, 'Daam sinises', 'T.Trubetski', 1986, 'Tallinn', 137, 'eesti', 25.00),
(10, 'Mina ja George', 'T.Trubetski', 1988, 'Tallinn', 153, 'eesti', 38.00),
(11, 'Kšitumise anatoomia', 'Sigmund Freud', 1997, 'Tallinn', 5, 'eesti', 395.00),
(12, 'Konstitutsioon', 'J.Stalin', 1944, 'Tallinn', 287, 'eesti', 56.00),
(13, 'Rahvas?brad', 'V.I.Lenin', 1951, 'Tallinn', 176, 'eesti', 23.00),
(14, 'Leninismi alustest', 'J.Stalin', 1945, 'Tallinn', 357, 'eesti', 65.00),
(15, 'Pimeduse pahem kšsi', 'U.K.LeQuine', 1975, 'Tallinn', 198, 'eesti', 55.00),
(16, 'Mis teha', 'J.K.Ibin', 1950, 'Tallinn', 175, 'eesti', 43.00),
(17, 'Surnud hinged', 'Nikolai Kogol', 1977, 'Tallinn', 298, 'eesti', 55.00),
(18, 'Kalevipoeg', 'A.Kiviršhk', 1997, 'Tallinn', 2, 'eesti', 60.00),
(19, 'Massi ebajumal', 'V.Lšcis', 1989, 'Tallinn', 376, 'eesti', 75.00),
(20, 'Inimesed maskides', 'V.Lšcis', 1989, 'Tallinn', 245, 'eesti', 130.00),
(21, 'Hiline kevad', 'V.Lšcis', 1989, 'Tallinn', 298, 'eesti', 89.00),
(22, 'Testament', 'Rex Stout', 1986, 'Tallinn', 187, 'eesti', 115.00),
(23, 'Pioneerid', 'J.F.Cooper', 1973, 'Tallinn', 398, 'eesti', 1.00),
(24, 'Surma ratsanikud', 'M.Kivistik', 1992, 'Tallinn', 287, 'eesti', 1.00),
(25, 'Kana ja muna', 'Kait Marandi', 1996, 'Tartu Helmes', 2, 'jaapani', 450.00),
(26, 'Naksitrallid', 'Ellen Niit', 1980, 'Tartu', 150, 'eesti', 45.00),
(27, 'Arvuti A ja B', 'Rein Hanson', 1978, 'USA', 7, 'inglise', 23.00),
(28, 'Kasuema', 'Silvia Rannamaa', 1923, 'Valga', 145, 'eesti', 45.00),
(29, 'Kunksmoor', 'Aino Perg', 1966, 'Tartu', 67, 'eesti', 75.00),
(30, 'Arabella', 'Aino Pervik', 1985, 'Tallinn', 187, 'eesti', 876.00),
(31, 'Bullerby lapsed', 'Astrid Lindgren', 1982, 'Rootsi', 199, 'rootsi', 26.00),
(32, 'Muumitrollid', 'Tove Janson', 1998, 'Norra', 4, 'norra', 77.00),
(33, 'Ja pšike t?useb', 'Hernst Hemingway', 1938, 'USA', 234, 'inglise', 327.00),
(34, 'Vanamees ja meri', 'Hernst Hemingway', 1964, 'USA', 312, 'inglise', 83.00),
(35, '10 aastat hiljem', 'Alexander Dumas', 1955, 'Pariis', 183, 'prantsuse', 821.00),
(36, 'Nukitsamees', 'Oskar Luts', 1977, 'Tallinn', 87, 'eesti', 32.00),
(37, 'Soo', 'Oskar Luts', 1971, 'Tartu', 56, 'eesti', 45.00),
(38, 'Vari', 'Juhan Liiv', 1928, 'Tartu', 287, 'eesti', 63.00),
(39, 'Vares', 'J?ri Tuulik', 1948, 'Tallinn', 253, 'eesti', 72.00),
(40, 'Kevade', 'Oskar Luts', 1997, 'Tartu', 188, 'eesti', 33.00),
(41, 'Suvi', 'Oskar Luts', 1988, 'Narva', 162, 'eesti', 79.00),
(42, 'S?da ja rahu', 'Lev Tolstoi', 1963, 'Moskva', 645, 'vene', 143.00),
(43, 'Kurit?? ja karistus', 'Dostojevski', 1973, 'Moskva', 487, 'vene', 52.00),
(44, 'Saladuslik saar', 'Jules Verne', 1956, 'Pariis', 682, 'eesti', 62.00),
(45, '', NULL, NULL, NULL, NULL, '', NULL),
(47, '', NULL, NULL, NULL, NULL, '', 800.00),
(48, '', NULL, NULL, NULL, NULL, '', 800.00),
(49, '', NULL, NULL, NULL, NULL, '', 800.00),
(50, '', NULL, NULL, NULL, NULL, '', 800.00),
(51, '', NULL, NULL, NULL, NULL, '', 800.00),
(52, '', NULL, NULL, NULL, NULL, '', 800.00),
(53, '', NULL, NULL, NULL, NULL, '', 800.00),
(54, '', NULL, NULL, NULL, NULL, '', 800.00),
(55, '', NULL, NULL, NULL, NULL, '', 800.00),
(56, '', NULL, NULL, NULL, NULL, '', 800.00);

--
-- Päästikud `RAAMAT`
--
DELIMITER $$
CREATE TRIGGER `KUSTUTATI` AFTER DELETE ON `RAAMAT` FOR EACH ROW INSERT into Keskmine(kuupäev, Keskmine_Hind) VALUES
(now(), (select avg(Hind) from RAAMAT))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `LISATI` AFTER INSERT ON `RAAMAT` FOR EACH ROW INSERT into Keskmine (Kuupäev, Keskmine_hind) VALUES
(now(), (select AVG(Hind) from RAAMAT))
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `MUUDETI` AFTER UPDATE ON `RAAMAT` FOR EACH ROW INSERT into Keskmine (Kuupäev, Keskmine_hind) VALUES
(now(), (select avg(Hind) from RAAMAT))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `Synnid`
--

CREATE TABLE `Synnid` (
  `Synnikuupaev` varchar(10) DEFAULT NULL,
  `Ema_id` varchar(2) DEFAULT NULL,
  `L_nimi` varchar(9) DEFAULT NULL,
  `Elukoht` varchar(10) DEFAULT NULL,
  `Synniaeg` varchar(5) DEFAULT NULL,
  `Synnikaal` varchar(4) DEFAULT NULL,
  `Synnipikkus` varchar(2) DEFAULT NULL,
  `Sugu` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Andmete tõmmistamine tabelile `Synnid`
--

INSERT INTO `Synnid` (`Synnikuupaev`, `Ema_id`, `L_nimi`, `Elukoht`, `Synniaeg`, `Synnikaal`, `Synnipikkus`, `Sugu`) VALUES
('2007-01-18', '1', 'Richard', 'Tallinn', '22:59', '2385', '46', 'p'),
('2007-01-19', '2', 'Ralf', 'Tallinn', '13:08', '3736', '50', 'p'),
('2007-01-20', '3', 'Karolin', 'Tallinn', '19:42', '3538', '51', 't'),
('2007-01-21', '4', 'Liisi', 'Tallinn', '0:12', '2920', '48', 't'),
('2007-01-22', '5', 'Kaur', 'Tallinn', '0:53', '2610', '46', 'p'),
('2007-01-23', '6', 'Rasmus', 'Keila', '13:41', '2462', '47', 'p'),
('2007-01-24', '7', 'Ramona', 'Tallinn', '18:27', '2473', '47', 't'),
('2007-01-25', '8', 'Otto', 'Tallinn', '9:15', '3148', '50', 'p'),
('2007-01-26', '8', 'Konrad', 'Tallinn', '9:17', '2652', '50', 'p'),
('2007-01-27', '9', 'Karola', 'Helsingi', '18:28', '3545', '50', 't'),
('2007-01-28', '10', 'Sten', 'Tartu', '12:23', '3740', '51', 'p'),
('2007-01-29', '11', 'Steven', 'Tartu', '23:47', '3850', '52', 'p'),
('2007-01-30', '12', 'Heike', 'Tallinn', '11:17', '3450', '50', 't'),
('2007-01-31', '13', 'Aneteliis', 'Tartu', '19:25', '3290', '49', 't'),
('2007-02-01', '14', 'Lysandra', 'Tyri ', '15:41', '4040', '51', 't'),
('2007-02-02', '15', 'Kelly', 'Tallinn', '22:44', '3250', '50', 't'),
('2007-02-03', '16', 'Rihard', 'Tallinn', '2:52', '4140', '52', 'p'),
('2007-02-04', '17', 'Sander', 'Tallinn', '17:43', '3330', '50', 'p'),
('2007-02-05', '18', 'Marten', 'Tallinn', '3:28', '3756', '51', 'p'),
('2007-02-06', '19', 'Bairon', 'Tartu', '6:05', '2710', '49', 'p'),
('2007-02-07', '20', 'Inga', 'Tallinn', '6:18', '3056', '48', 't'),
('2007-02-08', '21', 'Sebastian', 'Tallinn', '14:49', '2818', '48', 'p'),
('2007-02-09', '22', 'Jaan', 'Tallinn', '1:27', '3496', '51', 'p'),
('2007-02-10', '23', 'Elis', 'Tallinn', '10:54', '2760', '47', 't'),
('2007-02-11', '24', 'Heleriin', 'Tartu', '14:51', '3398', '51', 't'),
('2007-02-12', '25', 'Andres', 'Tallinn', '3:15', '4345', '53', 'p'),
('2007-02-13', '26', 'Melani', 'Paide', '12:50', '3150', '51', 't'),
('2007-02-14', '27', 'Joosep', 'Viljandi', '23:42', '3460', '49', 'p'),
('2007-02-15', '28', 'Sebastian', 'Tallinn', '5:20', '3876', '52', 'p'),
('2007-02-16', '29', 'Kaidro', 'Tallinn', '11:33', '3670', '53', 'p'),
('2007-02-17', '30', 'Rasmus', 'Tallinn', '4:05', '3670', '52', 'p'),
('2007-02-18', '31', 'Ralf', 'Tallinn', '17:21', '4842', '52', 'p'),
('2007-02-19', '32', 'Jessika', 'Tallinn', '23:15', '3670', '53', 't'),
('2007-02-20', '33', 'Prank', 'Tallinn', '1:13', '3166', '53', 'p'),
('2007-02-21', '34', 'Lars', 'Tartu', '7:58', '3090', '50', 'p'),
('2007-02-22', '35', 'Oliver', 'Tartu', '20:27', '3640', '50', 'p'),
('2007-02-23', '36', 'Marelle', 'Tallinn', '13:36', '4100', '51', 't'),
('2007-02-24', '37', 'Kelli', 'Tallinn', '19:06', '3540', '52', 't'),
('2007-02-25', '38', 'Karina', 'Tartu', '14:55', '3400', '51', 't'),
('2007-02-26', '39', 'Maria', 'Tallinn', '20:51', '3986', '51', 't'),
('2007-02-27', '40', 'Marinel', 'Tallinn', '15:22', '4062', '51', 't'),
('2007-02-28', '41', 'Lisandra', 'Kuressaare', '20:08', '3186', '49', 't'),
('2007-03-01', '42', 'Gregori', 'Tallinn', '3:22', '3910', '51', 'p'),
('2007-03-02', '43', 'Mirell', 'Tallinn', '3:05', '4080', '54', 't'),
('2007-03-03', '44', 'Meribel', 'Paide', '9:35', '4040', '53', 't'),
('2007-03-04', '45', 'Merike', 'Tallinn', '20:56', '3912', '53', 't'),
('2007-03-05', '46', 'Tanel', 'Tallinn', '23:09', '3104', '48', 'p'),
('2007-03-06', '47', 'Emil', 'Tartu', '0:15', '3410', '50', 'p'),
('2007-03-07', '48', 'Marek', 'Tallinn', '4:55', '4600', '51', 'p'),
('2007-03-08', '49', 'Merike', 'Paide', '1:43', '3800', '52', 't'),
('2007-03-09', '50', 'Rita', 'Tallinn', '1:37', '3778', '52', 't'),
('', '', '', '', '', '', '', ''),
('', '', 'Jussike J', '', '', '2679', '', 'p'),
('2007-01-18', '', 'Jane', 'Tartu', '22:59', '2879', '46', 't'),
('1988', '1', 'Peeter', 'Tartu', '22', '2800', '46', 'p'),
('2008-02-24', '2', 'Jane', 'Tartu', '23:00', '2600', '47', 't'),
('2009-06-06', '46', 'Kalle-Pel', 'Kapa-Kohil', '21:05', '3001', '46', 'p'),
('2004-02-24', '10', 'Koit Haav', 'Tartu', '21:35', '2999', '46', 'p'),
('2003-02-12', '10', 'Pafnuti', 'Tallinn', '21:39', '2880', '44', 'p');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `AINE`
--
ALTER TABLE `AINE`
  ADD PRIMARY KEY (`a_kood`);

--
-- Indeksid tabelile `AINE_OPILANE`
--
ALTER TABLE `AINE_OPILANE`
  ADD KEY `aine_kood` (`aine_kood`),
  ADD KEY `o_isikukood` (`o_isikukood`),
  ADD KEY `opetaja_kood` (`opetaja_kood`);

--
-- Indeksid tabelile `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`content_id`);

--
-- Indeksid tabelile `KLIENDID`
--
ALTER TABLE `KLIENDID`
  ADD PRIMARY KEY (`Kliendi_id`);

--
-- Indeksid tabelile `K_logi`
--
ALTER TABLE `K_logi`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksid tabelile `LAENUTAMINE`
--
ALTER TABLE `LAENUTAMINE`
  ADD PRIMARY KEY (`Laenutamise_id`),
  ADD KEY `Raamatu_id` (`Raamatu_id`),
  ADD KEY `Lugeja_id` (`Lugeja_id`);

--
-- Indeksid tabelile `LUGEJA`
--
ALTER TABLE `LUGEJA`
  ADD PRIMARY KEY (`Lugeja_id`);

--
-- Indeksid tabelile `OPETAJA`
--
ALTER TABLE `OPETAJA`
  ADD PRIMARY KEY (`opetaja_isikuk`),
  ADD KEY `juhend_grupp` (`juhend_grupp`);

--
-- Indeksid tabelile `OPILANE`
--
ALTER TABLE `OPILANE`
  ADD PRIMARY KEY (`isikukood`),
  ADD KEY `g_kood` (`g_kood`);

--
-- Indeksid tabelile `OSAKOND`
--
ALTER TABLE `OSAKOND`
  ADD PRIMARY KEY (`o_kood`);

--
-- Indeksid tabelile `O_GRUPP`
--
ALTER TABLE `O_GRUPP`
  ADD PRIMARY KEY (`o_gr_kood`),
  ADD KEY `o_kood` (`o_kood`);

--
-- Indeksid tabelile `RAAMAT`
--
ALTER TABLE `RAAMAT`
  ADD PRIMARY KEY (`Raamatu_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `AINE`
--
ALTER TABLE `AINE`
  MODIFY `a_kood` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT tabelile `content`
--
ALTER TABLE `content`
  MODIFY `content_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT tabelile `KLIENDID`
--
ALTER TABLE `KLIENDID`
  MODIFY `Kliendi_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT tabelile `K_logi`
--
ALTER TABLE `K_logi`
  MODIFY `ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT tabelile `LAENUTAMINE`
--
ALTER TABLE `LAENUTAMINE`
  MODIFY `Laenutamise_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT tabelile `LUGEJA`
--
ALTER TABLE `LUGEJA`
  MODIFY `Lugeja_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
--
-- AUTO_INCREMENT tabelile `OSAKOND`
--
ALTER TABLE `OSAKOND`
  MODIFY `o_kood` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT tabelile `O_GRUPP`
--
ALTER TABLE `O_GRUPP`
  MODIFY `o_gr_kood` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT tabelile `RAAMAT`
--
ALTER TABLE `RAAMAT`
  MODIFY `Raamatu_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
