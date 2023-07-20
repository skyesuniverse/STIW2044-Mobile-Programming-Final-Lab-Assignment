-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 20, 2023 at 07:20 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barteritfinal_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_items`
--

CREATE TABLE `tbl_items` (
  `item_id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `item_desc` varchar(200) NOT NULL,
  `item_category` varchar(40) NOT NULL,
  `item_price` float NOT NULL,
  `item_qty` float NOT NULL,
  `item_lat` varchar(20) NOT NULL,
  `item_long` varchar(20) NOT NULL,
  `item_state` varchar(20) NOT NULL,
  `item_locality` varchar(20) NOT NULL,
  `item_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_items`
--

INSERT INTO `tbl_items` (`item_id`, `user_id`, `item_name`, `item_desc`, `item_category`, `item_price`, `item_qty`, `item_lat`, `item_long`, `item_state`, `item_locality`, `item_date`) VALUES
(1, 1, 'Monitor ', 'LG Monitor with IPS technology highlights the performance of liquid crystal displays. Response times are shortened, color reproduction is improved, and users can view the screen at wide angles.', 'Electronics', 458, 3, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(2, 1, 'Skateboard', 'WhiteFang Skateboards for Beginners, Complete Skateboard 31 x 7.88, 7 Layer Canadian Maple Double Kick Concave Standard and Tricks Skateboards for Kids and Beginners', 'Sports', 49, 2, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(3, 1, 'Sofa', 'Elevate your living space with our stylish Brown Sofa, designed for comfort and sophistication. Its rich brown upholstery complements any decor, adding a touch of elegance to your home.', 'Furniture', 350, 2, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(4, 1, 'Face Mask', 'NEUTROVIS Exclusive Bundle Pack 3 in 1 features our 3-ply Medical Face Mask in Sky Blue & Arctic Lime (10 pcs each) + FREE 4-ply Premium Medical Face Mask in Denim Blue (5 pcs).', 'Health', 9.9, 5, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(5, 2, 'Monopoly Game', 'Monopoly Game, Family Board Games for 2 to 6 Players & Kids Ages 8 and Up', 'Toys or Hobbies', 15.8, 1, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(6, 2, 'Kettle', 'Philips HD9350 Daily Collection Electric Kettle. Durable kettle in safe, food-grade stainless steel for long and reliable daily use. ', 'Electronics', 159, 6, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(7, 2, 'PingPong Racket', 'Professional Racket - Table Tennis Racket - ITTF Approved Rubber for Tournament Play - Best Table Tennis Paddle', 'Sports', 69.8, 2, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(8, 2, 'UNO Game', 'Classic Colour & Number Matching Card Game - 112 Cards - Customizable & Erasable Wild - Special Action Cards Included', 'Toys or Hobbies', 35, 12, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-05'),
(9, 2, 'Cubic', 'The ShengShou Legend 3x3 (Metallic) has a beautiful outer coating that looks extremely metallic. Great as a show piece and the turning is good right out of the box!', 'Toys or Hobbies', 25, 8, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-20'),
(10, 2, 'Sunglasses', '-Imported\n-Composite frame\n-Tri Acetate Cellulose lens\n-Polarized\n-UV Protection Coating coating', 'Fashion', 99, 5, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-20'),
(11, 1, 'Ffrisbee', 'Single assorted color flying disc, ideal for a recreational game of catch or a competitive disc golf match. Disc weight of 95 grams', 'Sports', 56, 9, '4.6005117', '101.0757833', 'Perak', 'Ipoh', '2023-07-20');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `order_id` int(5) NOT NULL,
  `order_bill` varchar(8) NOT NULL,
  `order_paid` float NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `order_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `order_status` varchar(20) NOT NULL,
  `order_lat` varchar(12) NOT NULL,
  `order_lng` varchar(12) NOT NULL,
  `item_id` int(5) NOT NULL,
  `order_qty` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_orders`
--

INSERT INTO `tbl_orders` (`order_id`, `order_bill`, `order_paid`, `buyer_id`, `seller_id`, `order_date`, `order_status`, `order_lat`, `order_lng`, `item_id`, `order_qty`) VALUES
(1, 'ORD85287', 463, '2', '1', '2023-07-20 15:09:26.000000', 'Ready', '4.6005117', '101.0757833', 1, 1),
(2, 'ORD41369', 463, '2', '1', '2023-07-20 16:00:18.000000', 'New', '4.6005117', '101.0757833', 1, 1),
(3, 'ORD24323', 20.8, '1', '2', '2023-07-20 17:30:04.000000', 'Completed', '4.6005117', '101.0757833', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(30) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_otp` int(5) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `user_address` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_password`, `user_otp`, `user_datereg`, `user_address`) VALUES
(1, 'mobile@gmail.com', 'Mobile123', '4ec038107fa4f1178856b01104385c678a873f5c', 42643, '2023-06-12 17:23:38.037419', 'No.103, Taman Pelangi, 06000 Jitra, Kedah.'),
(2, 'johnson@gmail.com', 'Johnsony', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 85356, '2023-07-16 12:03:58.007492', 'No.98, Taman Ceria, 06000 Jitra, Kedah.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `item_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  MODIFY `order_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
