-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 04, 2023 at 12:05 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wa_api`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_info`
-- (See below for the actual view)
--
CREATE TABLE `v_info` (
`message` mediumtext
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_wa_contact`
-- (See below for the actual view)
--
CREATE TABLE `v_wa_contact` (
`from_number` varchar(24)
,`message` varchar(226)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_wa_pilih`
-- (See below for the actual view)
--
CREATE TABLE `v_wa_pilih` (
`message` mediumtext
);

-- --------------------------------------------------------

--
-- Table structure for table `wa_contact`
--

CREATE TABLE `wa_contact` (
  `id` int(11) NOT NULL,
  `from_number` varchar(24) NOT NULL,
  `name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(16) NOT NULL,
  `nik` int(32) NOT NULL,
  `valid_date` date NOT NULL,
  `create_date` date NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `role` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `wa_contact`
--

INSERT INTO `wa_contact` (`id`, `from_number`, `name`, `email`, `password`, `nik`, `valid_date`, `create_date`, `username`, `role`) VALUES
(1, '6281315609387@c.us', 'Rian Budi Setiawan', 'rbsetiawan@gmail.com', 'passaya@123', 1010101010, '2023-03-02', '2023-03-02', 'rbsetiawan', 2);

-- --------------------------------------------------------

--
-- Table structure for table `wa_pilih`
--

CREATE TABLE `wa_pilih` (
  `id` int(11) NOT NULL,
  `activity` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `date_start` date NOT NULL DEFAULT current_timestamp(),
  `date_end` date DEFAULT NULL,
  `exception` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `wa_pilih`
--

INSERT INTO `wa_pilih` (`id`, `activity`, `description`, `date_start`, `date_end`, `exception`) VALUES
(1, 'Ketua OSIS', '', '2023-03-03', NULL, 0),
(2, 'Ketua Kelas XII A', '', '2023-03-03', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `wa_replay`
--

CREATE TABLE `wa_replay` (
  `id` int(11) NOT NULL,
  `keyword` varchar(128) NOT NULL,
  `message` text NOT NULL,
  `description` text NOT NULL,
  `exception` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `wa_replay`
--

INSERT INTO `wa_replay` (`id`, `keyword`, `message`, `description`, `exception`) VALUES
(1, 'ping', 'pong', 'Test Connection', 0),
(2, 'info', 'pilih salah satu:\r\n\r\nkandidat\r\nsaya\r\npassword\r\n', 'Pilihan pesan yang dapat di tanggapi', 1),
(3, 'saya', '', 'Informasi Profil Saya', 1),
(4, 'pilih', '', 'Kegiatan Pemilihan yang sedan berlangsung', 1);

-- --------------------------------------------------------

--
-- Structure for view `v_info`
--
DROP TABLE IF EXISTS `v_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_info`  AS  select replace(group_concat(concat('*',`wr`.`keyword`,'*',' | description : ',`wr`.`description`,char(10)) separator ','),',','') AS `message` from `wa_replay` `wr` ;

-- --------------------------------------------------------

--
-- Structure for view `v_wa_contact`
--
DROP TABLE IF EXISTS `v_wa_contact`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_wa_contact`  AS  select `wc`.`from_number` AS `from_number`,concat('HALLO selamat datang di system kami ',char(10),'NIK: ',`wc`.`nik`,char(10),'NAMA: ',`wc`.`name`,char(10),'EMAIL: ',`wc`.`email`) AS `message` from `wa_contact` `wc` ;

-- --------------------------------------------------------

--
-- Structure for view `v_wa_pilih`
--
DROP TABLE IF EXISTS `v_wa_pilih`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_wa_pilih`  AS  select replace(group_concat(concat('*',`wp`.`activity`,'*',' | description : ',`wp`.`description`,char(10)) separator ','),',','') AS `message` from `wa_pilih` `wp` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `wa_contact`
--
ALTER TABLE `wa_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wa_pilih`
--
ALTER TABLE `wa_pilih`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wa_replay`
--
ALTER TABLE `wa_replay`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `wa_contact`
--
ALTER TABLE `wa_contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wa_pilih`
--
ALTER TABLE `wa_pilih`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wa_replay`
--
ALTER TABLE `wa_replay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
