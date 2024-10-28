-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2024 at 04:29 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fashionworld`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `stock` int(11) DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image_url`, `price`, `description`, `stock`) VALUES
(1, 'Chronics', '/static/images/dress/dress1.jpeg', 499.99, 'A black sleeveless dress with a deep V-neckline', 10),
(2, 'Jaguar', '/static/images/dress/dress2.jpeg', 599.99, 'The leather jacket fits well, defining her waist and creating a balanced silhouette with tight torn jeans and white tank top', 10),
(3, 'Paris Collection', '/static/images/dress/dress3.jpeg', 399.99, 'A white T-shirt tucked in with blue and red aesthetic print and a blue knee-length skirt', 10),
(4, 'Simples', '/static/images/dress/dress4.jpeg', 499.99, 'Contrasting both shades of grey with a V-neckline T-shirt and tight jeans', 10),
(5, 'Wizards', '/static/images/dress/dress5.jpeg', 599.99, 'Sleeveless blue top with a wrap-style design, featuring a slightly asymmetrical collar and a deep V-neckline, paired with high-waisted, cream-colored trousers', 10),
(6, 'Pearl', '/static/images/dress/dress6.jpeg', 399.99, 'Formal look complemented with a red satin shirt and high-waisted olive green trousers', 10),
(7, 'rome_antic', '/static/images/dress/dress7.jpeg', 499.99, 'Pink fishnet cool design with exclusive tight jeans', 10),
(8, 'Fish', '/static/images/dress/dress8.jpeg', 599.99, 'Crop top with lace and mesh details and denim shorts', 10),
(9, 'Trends', '/static/images/dress/dress9.jpeg', 399.99, 'Jogger outfit that could also be worn on special occasions', 10),
(10, 'nambi', '/static/images/dress/dress10.jpeg', 399.99, 'Light blue shirt tucked upward, paired with black formal jeans', 10),
(11, 'Professionals', '/static/images/dress/dress11.jpeg', 399.99, 'Formal shirt paired with a black blazer and Raymond trousers', 10);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(1, 'test1', 'test1@gmail.com', '$2b$12$wIQ3Sf3EnyUfrTYsUXRvqurjx8dwESmqWATH7i6U7HJrlJF22hBce'),
(2, 'test2', 'test2@gmail.com', '$2b$12$RDmiqXeZPkQYuNTh1NPp2.Ws74rdChssiQ.3vJpleb7CrMtCNKxJu'),
(3, 'test1', 'test1123@gmail.com', '$2b$12$TV2upxqKQ6mRrXACbqvqteAjfr//QPOJHpBDT05G4kGAT8SWW7Ny2'),
(4, 'test1', 'test1123@gmail.com', '$2b$12$uMQIya82rFFrXJ9MgNNyveQBiRytmVOCAOasXPBiV9Hs/GTVNrRra');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
