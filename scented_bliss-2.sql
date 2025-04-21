-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 21, 2025 at 08:32 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scented_bliss`
--
CREATE DATABASE IF NOT EXISTS `scented_bliss` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `scented_bliss`;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE IF NOT EXISTS `cart` (
  `cartId` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`cartId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_user_product`
--

CREATE TABLE IF NOT EXISTS `cart_user_product` (
  `cartId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  PRIMARY KEY (`cartId`,`userId`,`productId`),
  KEY `userId` (`userId`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(100) NOT NULL,
  `categoryDescription` text NOT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category_user_product`
--

CREATE TABLE IF NOT EXISTS `category_user_product` (
  `categoryId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  PRIMARY KEY (`categoryId`,`userId`,`productId`),
  KEY `userId` (`userId`),
  KEY `productId` (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderitem`
--

CREATE TABLE IF NOT EXISTS `orderitem` (
  `orderItemId` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unitPrice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `subTotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`orderItemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderitem_user`
--

CREATE TABLE IF NOT EXISTS `orderitem_user` (
  `orderItemId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  PRIMARY KEY (`orderItemId`,`userId`,`productId`,`orderId`),
  KEY `orderId` (`orderId`),
  KEY `productId` (`productId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT,
  `orderDate` datetime NOT NULL DEFAULT current_timestamp(),
  `totalAmount` decimal(10,2) NOT NULL,
  `shippingAddress` varchar(100) NOT NULL,
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_user`
--

CREATE TABLE IF NOT EXISTS `order_user` (
  `orderId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `paymentId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  PRIMARY KEY (`orderId`,`userId`,`paymentId`,`productId`),
  KEY `paymentId` (`paymentId`),
  KEY `productId` (`productId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE IF NOT EXISTS `payment` (
  `paymentId` int(11) NOT NULL AUTO_INCREMENT,
  `paymentMethod` varchar(50) NOT NULL,
  `paymentStatus` varchar(50) NOT NULL DEFAULT 'Pending',
  `transactionId` varchar(100) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`paymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(100) NOT NULL,
  `productDescription` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `Quantity` int(20) NOT NULL,
  PRIMARY KEY (`productId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE IF NOT EXISTS `review` (
  `reviewId` int(11) NOT NULL AUTO_INCREMENT,
  `reviewText` text NOT NULL,
  `rating` decimal(2,1) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`reviewId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review_user_product`
--

CREATE TABLE IF NOT EXISTS `review_user_product` (
  `reviewId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  PRIMARY KEY (`reviewId`,`userId`,`productId`),
  KEY `productId` (`productId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phoneNumber` varchar(10) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `role` enum('Customer','Admin') NOT NULL,
  `imageUrl` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phoneNo` (`phoneNumber`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userId`, `firstName`, `lastName`, `address`, `email`, `phoneNumber`, `gender`, `username`, `password`, `dob`, `role`, `imageUrl`) VALUES
(1, 'Soniya', 'Sapkota', 'Kausaltar', 'soni123@gmail.com', '9867543212', 'Female', 'Soniya', 'Soniya@123', '2006-04-06', 'Customer', 'Soni.jpg'),
(2, 'Test', 'User', '123 Street', 'test@example.com', '1234567890', 'Other', 'testuser', 'password123', '2000-01-01', 'Customer', 'default.jpg'),
(3, 'Swayam', 'Chaulagain', 'kathmandu', 'swayam01@gmail.com', '9867453322', 'Male', 'Swayam124', 'jl/cvqQcMctceUJ78MIB43cWkHacmiSa1sk6FV1s2fVGfOSHM7BTEBySPQ85YTXvpneRWJ9z7A==', '2000-01-01', 'Customer', 'perfumepic.jpg'),
(4, 'Sabin', 'Devkota', 'Bhaktapur', 'Sabin@gmail.com', '9876554532', 'Male', 'Sabin003', 'N6nkQrAUPE6wE8fkvnaB68Nw0Wut08NWJ8SCQwBC1noSUch++jAvtonTp7N3dcM2HATLyts=', '2000-09-01', 'Customer', 'darkish.jpg'),
(5, 'Ishpa', 'Maharjan', 'kathmandu', 'Ishpa21@gmail.com', '9877554466', 'Female', 'Ishpa005', '4aN1KxFuFhwhoCLWuGQFdvq9GxoMC756k/T9WcNoVN04bJypZrk7vNEkz3t5yiqPmCjynA==', '2001-02-02', 'Customer', 'registerimgg.jpg'),
(7, 'Soniya', 'Sapkota', 'kathmandu', 'soni12@gmail.com', '9865446623', 'Female', 'Soniya0001', 'EmZHjJdPiZF3pR/UD2aHYfqxy2gjXGqWbLTYrAPlvPhSjNofCTkai/B8wIZ2Z1sWluGp3uypkRw=', '2001-02-01', 'Customer', 'Registerimg.jpg'),
(9, 'Sadiksha', 'Karki', 'Bhaktapur', 'Sadiksha@gmail.com', '9867453312', 'Female', 'Sadiksha', 'C/ydiIqGCEPJGno+PMeddD+YtgFw2MD+MSyfM88kEswgoD8uRyKI4M7lQoxFlD195CyBZCSKiA==', '2002-03-02', 'Customer', 'sol.jpg'),
(10, 'Soniya', 'Sapkota', 'Bhaktapur', 'soniya223@gmail.com', '9876553321', 'Female', 'Soniya003', 'MYv5wvb//9cTHLh7bqIwkyOr9zBPLe5PWidncwC3bNIvD7b+k8k4WBhXDz81NYmngW8xoQVILU8=', '2003-01-01', 'Admin', 'registerback.jpg'),
(11, 'Soniya', 'Sapkota', 'Kausaltar', 'soni121@gmail.com', '9876553323', 'Female', 'Soniya011', 'n8ReucEe1xZSZPbGDPgdisi6mdTOsD0+psPkEPWR2qcJCLVBg6OIoR+K6E5tzrzt6ZdEam8I', '2007-12-11', 'Customer', 'wishlist.png');

-- --------------------------------------------------------

--
-- Table structure for table `user_product`
--

CREATE TABLE IF NOT EXISTS `user_product` (
  `productId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`productId`,`userId`),
  KEY `user_product_ibfk_1` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_user_product`
--
ALTER TABLE `cart_user_product`
  ADD CONSTRAINT `cart_user_product_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`),
  ADD CONSTRAINT `cart_user_product_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  ADD CONSTRAINT `cart_user_product_ibfk_3` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`);

--
-- Constraints for table `category_user_product`
--
ALTER TABLE `category_user_product`
  ADD CONSTRAINT `category_user_product_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`),
  ADD CONSTRAINT `category_user_product_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  ADD CONSTRAINT `category_user_product_ibfk_3` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`);

--
-- Constraints for table `orderitem_user`
--
ALTER TABLE `orderitem_user`
  ADD CONSTRAINT `orderitem_user_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`),
  ADD CONSTRAINT `orderitem_user_ibfk_2` FOREIGN KEY (`orderItemId`) REFERENCES `orderitem` (`orderItemId`),
  ADD CONSTRAINT `orderitem_user_ibfk_3` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  ADD CONSTRAINT `orderitem_user_ibfk_4` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `order_user`
--
ALTER TABLE `order_user`
  ADD CONSTRAINT `order_user_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`),
  ADD CONSTRAINT `order_user_ibfk_2` FOREIGN KEY (`paymentId`) REFERENCES `payment` (`paymentId`),
  ADD CONSTRAINT `order_user_ibfk_3` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  ADD CONSTRAINT `order_user_ibfk_4` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `review_user_product`
--
ALTER TABLE `review_user_product`
  ADD CONSTRAINT `review_user_product_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  ADD CONSTRAINT `review_user_product_ibfk_2` FOREIGN KEY (`reviewId`) REFERENCES `review` (`reviewId`),
  ADD CONSTRAINT `review_user_product_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `user_product`
--
ALTER TABLE `user_product`
  ADD CONSTRAINT `user_product_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  ADD CONSTRAINT `user_product_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
