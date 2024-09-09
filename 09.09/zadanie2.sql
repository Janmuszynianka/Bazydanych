-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Wrz 09, 2024 at 10:10 AM
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
-- Database: `zadanie2`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dostawcy`
--

CREATE TABLE `dostawcy` (
  `id_dostawcy` char(10) NOT NULL,
  `nazwa_dostawcy` char(50) DEFAULT NULL,
  `adres_urzedowania` char(50) DEFAULT NULL,
  `miasto` char(50) DEFAULT NULL,
  `wojewodztwo` char(20) DEFAULT NULL,
  `kod_pocztowy` char(10) DEFAULT NULL,
  `kraj` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `dostawcy`
--

INSERT INTO `dostawcy` (`id_dostawcy`, `nazwa_dostawcy`, `adres_urzedowania`, `miasto`, `wojewodztwo`, `kod_pocztowy`, `kraj`) VALUES
('D001', 'Pizzeria Italiano', 'ul. Włoska 12', 'Warszawa', 'Mazowieckie', '00-950', 'Polska'),
('D002', 'Burger House', 'ul. Amerykańska 8', 'Kraków', 'Małopolskie', '31-001', 'Polska');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klienci`
--

CREATE TABLE `klienci` (
  `id_klienta` char(10) NOT NULL,
  `nazwa_klienta` char(50) DEFAULT NULL,
  `adres_bilingowy` char(50) DEFAULT NULL,
  `adres_dostawy` enum('T','N') DEFAULT NULL,
  `miasto` char(50) DEFAULT NULL,
  `adres_kod` char(10) DEFAULT NULL,
  `wojewodztwo` char(25) DEFAULT NULL,
  `kraj` char(25) DEFAULT NULL,
  `numer_kontaktowy` char(20) DEFAULT NULL,
  `email` char(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `klienci`
--

INSERT INTO `klienci` (`id_klienta`, `nazwa_klienta`, `adres_bilingowy`, `adres_dostawy`, `miasto`, `adres_kod`, `wojewodztwo`, `kraj`, `numer_kontaktowy`, `email`) VALUES
('K001', 'Jan Kowalski', 'ul. Główna 10', 'T', 'Warszawa', '00-001', 'Mazowieckie', 'Polska', '123456789', 'jan.kowalski@example.com'),
('K002', 'Anna Nowak', 'ul. Krótka 5', 'N', 'Kraków', '30-001', 'Małopolskie', 'Polska', '987654321', 'anna.nowak@example.com');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `magazyn`
--

CREATE TABLE `magazyn` (
  `id_zamowienia` int(11) DEFAULT NULL,
  `zamowiony_element` char(50) DEFAULT NULL,
  `id_produktu` char(10) DEFAULT NULL,
  `ilosc` int(11) DEFAULT NULL,
  `cena` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `id_produktu` char(10) NOT NULL,
  `id_dostawcy` char(10) DEFAULT NULL,
  `nazwa_produktu` char(255) DEFAULT NULL,
  `cena_produktu` decimal(8,2) DEFAULT NULL,
  `opis_produktu` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `produkty`
--

INSERT INTO `produkty` (`id_produktu`, `id_dostawcy`, `nazwa_produktu`, `cena_produktu`, `opis_produktu`) VALUES
('P001', 'D001', 'Pizza Margherita', 25.50, 'Pizza z serem mozzarella i sosem pomidorowym'),
('P002', 'D002', 'Burger Classic', 15.00, 'Burger wołowy z sałatą, pomidorem i sosem BBQ'),
('P003', 'D001', 'Pasta Carbonara', 30.00, 'Makaron spaghetti z sosem carbonara');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienia`
--

CREATE TABLE `zamowienia` (
  `id_zamowienia` int(11) NOT NULL,
  `data_zamowienia` datetime DEFAULT NULL,
  `id_klienta` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Dumping data for table `zamowienia`
--

INSERT INTO `zamowienia` (`id_zamowienia`, `data_zamowienia`, `id_klienta`) VALUES
(1, '2024-09-01 10:00:00', 'K001'),
(2, '2024-09-02 11:30:00', 'K002');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `dostawcy`
--
ALTER TABLE `dostawcy`
  ADD PRIMARY KEY (`id_dostawcy`);

--
-- Indeksy dla tabeli `klienci`
--
ALTER TABLE `klienci`
  ADD PRIMARY KEY (`id_klienta`);

--
-- Indeksy dla tabeli `magazyn`
--
ALTER TABLE `magazyn`
  ADD KEY `id_zamowienia` (`id_zamowienia`),
  ADD KEY `id_produktu` (`id_produktu`);

--
-- Indeksy dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id_produktu`),
  ADD KEY `id_dostawcy` (`id_dostawcy`);

--
-- Indeksy dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD PRIMARY KEY (`id_zamowienia`),
  ADD KEY `id_klienta` (`id_klienta`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `magazyn`
--
ALTER TABLE `magazyn`
  ADD CONSTRAINT `magazyn_ibfk_1` FOREIGN KEY (`id_zamowienia`) REFERENCES `zamowienia` (`id_zamowienia`),
  ADD CONSTRAINT `magazyn_ibfk_2` FOREIGN KEY (`id_produktu`) REFERENCES `produkty` (`id_produktu`);

--
-- Constraints for table `produkty`
--
ALTER TABLE `produkty`
  ADD CONSTRAINT `produkty_ibfk_1` FOREIGN KEY (`id_dostawcy`) REFERENCES `dostawcy` (`id_dostawcy`);

--
-- Constraints for table `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD CONSTRAINT `zamowienia_ibfk_1` FOREIGN KEY (`id_klienta`) REFERENCES `klienci` (`id_klienta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
