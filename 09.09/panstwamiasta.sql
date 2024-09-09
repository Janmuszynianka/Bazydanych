-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Wrz 09, 2024 at 10:09 AM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `panstwamiasta`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `jezyk_narodowy`
--

CREATE TABLE `jezyk_narodowy` (
  `kod_kraju` char(3) NOT NULL,
  `jezyk_urzedowy` char(30) NOT NULL,
  `czy_jezyk_oficjalny` enum('T','N') DEFAULT NULL,
  `procent_uzycia` decimal(4,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jezyk_narodowy`
--

INSERT INTO `jezyk_narodowy` (`kod_kraju`, `jezyk_urzedowy`, `czy_jezyk_oficjalny`, `procent_uzycia`) VALUES
('DE', 'Niemiecki', 'T', 95.0),
('PL', 'Polski', 'T', 97.0),
('US', 'Angielski', 'T', 78.0),
('US', 'Hiszpański', 'N', 13.0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kraj`
--

CREATE TABLE `kraj` (
  `kod_kraju` char(3) NOT NULL,
  `nazwa` char(52) DEFAULT NULL,
  `kontynent` enum('azja','europa','ameryka północna','ameryka południowa','afryka','antarktyda','oceania') DEFAULT NULL,
  `region_swiata` char(26) DEFAULT NULL,
  `powierzchnia` decimal(10,2) DEFAULT NULL,
  `rok_uzyskania_niepodleglosci` smallint(6) DEFAULT NULL,
  `ilosc_ludnosci` int(11) DEFAULT NULL,
  `sredni_dożywany_wiek` decimal(3,1) DEFAULT NULL,
  `PNB` decimal(10,2) DEFAULT NULL,
  `stolica` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kraj`
--

INSERT INTO `kraj` (`kod_kraju`, `nazwa`, `kontynent`, `region_swiata`, `powierzchnia`, `rok_uzyskania_niepodleglosci`, `ilosc_ludnosci`, `sredni_dożywany_wiek`, `PNB`, `stolica`) VALUES
('DE', 'Niemcy', 'europa', 'Zachodnia Europa', 357022.00, 1871, 83783942, 81.1, 99999999.99, 2),
('PL', 'Polska', 'europa', 'Wschodnia Europa', 312696.00, 1918, 38386000, 78.7, 99999999.99, 1),
('US', 'Stany Zjednoczone', 'ameryka północna', 'Ameryka Północna', 9372610.00, 1776, 331002651, 79.1, 99999999.99, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `stolica_krajowa`
--

CREATE TABLE `stolica_krajowa` (
  `id` int(11) NOT NULL,
  `nazwa` char(35) DEFAULT NULL,
  `kod_kraju` char(3) DEFAULT NULL,
  `populacja` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stolica_krajowa`
--

INSERT INTO `stolica_krajowa` (`id`, `nazwa`, `kod_kraju`, `populacja`) VALUES
(1, 'Warszawa', 'PL', 1790658),
(2, 'Berlin', 'DE', 3748148),
(3, 'Waszyngton', 'US', 705749);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `jezyk_narodowy`
--
ALTER TABLE `jezyk_narodowy`
  ADD PRIMARY KEY (`kod_kraju`,`jezyk_urzedowy`);

--
-- Indeksy dla tabeli `kraj`
--
ALTER TABLE `kraj`
  ADD PRIMARY KEY (`kod_kraju`);

--
-- Indeksy dla tabeli `stolica_krajowa`
--
ALTER TABLE `stolica_krajowa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kod_kraju` (`kod_kraju`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jezyk_narodowy`
--
ALTER TABLE `jezyk_narodowy`
  ADD CONSTRAINT `jezyk_narodowy_ibfk_1` FOREIGN KEY (`kod_kraju`) REFERENCES `kraj` (`kod_kraju`);

--
-- Constraints for table `stolica_krajowa`
--
ALTER TABLE `stolica_krajowa`
  ADD CONSTRAINT `stolica_krajowa_ibfk_1` FOREIGN KEY (`kod_kraju`) REFERENCES `kraj` (`kod_kraju`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
