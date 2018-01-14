-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 15, 2018 at 01:44 AM
-- Server version: 5.7.20
-- PHP Version: 7.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `title`) VALUES
(1, 'Suitcase category');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `sku` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `product_base_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `sku`, `title`, `price`, `product_base_id`) VALUES
(1, 'SC', 'Suitcase', '100.00', NULL),
(2, 'SC-R', 'Suitcase Red', '120.00', 1),
(3, 'SC-G', 'Suitcase Green', NULL, 1),
(4, 'SL', 'Slippers', '20.00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`product_id`, `category_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_feature`
--

CREATE TABLE `product_feature` (
  `id` int(11) NOT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lang` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product_feature`
--

INSERT INTO `product_feature` (`id`, `type`, `title`, `lang`, `product_id`) VALUES
(1, 'width', '60 cm', 'en', 1),
(2, 'height', '40 cm', 'en', 1),
(3, 'width', '60 см', 'ru', 1),
(4, 'height', '40 см', 'ru', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_feature_category`
--

CREATE TABLE `product_feature_category` (
  `product_feature_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `product_feature_category`
--

INSERT INTO `product_feature_category` (`product_feature_id`, `category_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D34A04ADF9038C4` (`sku`),
  ADD KEY `IDX_D34A04ADB8BEC4F1` (`product_base_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `IDX_CDFC73564584665A` (`product_id`),
  ADD KEY `IDX_CDFC735612469DE2` (`category_id`);

--
-- Indexes for table `product_feature`
--
ALTER TABLE `product_feature`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_CE0E6ED64584665A` (`product_id`),
  ADD KEY `lang_idx` (`lang`,`product_id`);

--
-- Indexes for table `product_feature_category`
--
ALTER TABLE `product_feature_category`
  ADD PRIMARY KEY (`product_feature_id`,`category_id`),
  ADD KEY `IDX_F12DD202F383E752` (`product_feature_id`),
  ADD KEY `IDX_F12DD20212469DE2` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_feature`
--
ALTER TABLE `product_feature`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04ADB8BEC4F1` FOREIGN KEY (`product_base_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `FK_CDFC735612469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_CDFC73564584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_feature`
--
ALTER TABLE `product_feature`
  ADD CONSTRAINT `FK_CE0E6ED64584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `product_feature_category`
--
ALTER TABLE `product_feature_category`
  ADD CONSTRAINT `FK_F12DD20212469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_F12DD202F383E752` FOREIGN KEY (`product_feature_id`) REFERENCES `product_feature` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
