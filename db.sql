-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ecommerceforfinal
CREATE DATABASE IF NOT EXISTS `ecommerceforfinal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ecommerceforfinal`;

-- Dumping structure for table ecommerceforfinal.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.auth_group: ~0 rows (approximately)

-- Dumping structure for table ecommerceforfinal.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.auth_group_permissions: ~0 rows (approximately)

-- Dumping structure for table ecommerceforfinal.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.auth_permission: ~64 rows (approximately)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add address', 7, 'add_address'),
	(26, 'Can change address', 7, 'change_address'),
	(27, 'Can delete address', 7, 'delete_address'),
	(28, 'Can view address', 7, 'view_address'),
	(29, 'Can add cart', 8, 'add_cart'),
	(30, 'Can change cart', 8, 'change_cart'),
	(31, 'Can delete cart', 8, 'delete_cart'),
	(32, 'Can view cart', 8, 'view_cart'),
	(33, 'Can add category', 9, 'add_category'),
	(34, 'Can change category', 9, 'change_category'),
	(35, 'Can delete category', 9, 'delete_category'),
	(36, 'Can view category', 9, 'view_category'),
	(37, 'Can add feature', 10, 'add_feature'),
	(38, 'Can change feature', 10, 'change_feature'),
	(39, 'Can delete feature', 10, 'delete_feature'),
	(40, 'Can view feature', 10, 'view_feature'),
	(41, 'Can add order detail', 11, 'add_orderdetail'),
	(42, 'Can change order detail', 11, 'change_orderdetail'),
	(43, 'Can delete order detail', 11, 'delete_orderdetail'),
	(44, 'Can view order detail', 11, 'view_orderdetail'),
	(45, 'Can add slider', 12, 'add_slider'),
	(46, 'Can change slider', 12, 'change_slider'),
	(47, 'Can delete slider', 12, 'delete_slider'),
	(48, 'Can view slider', 12, 'view_slider'),
	(49, 'Can add checkout', 13, 'add_checkout'),
	(50, 'Can change checkout', 13, 'change_checkout'),
	(51, 'Can delete checkout', 13, 'delete_checkout'),
	(52, 'Can view checkout', 13, 'view_checkout'),
	(53, 'Can add order', 14, 'add_order'),
	(54, 'Can change order', 14, 'change_order'),
	(55, 'Can delete order', 14, 'delete_order'),
	(56, 'Can view order', 14, 'view_order'),
	(57, 'Can add payment', 15, 'add_payment'),
	(58, 'Can change payment', 15, 'change_payment'),
	(59, 'Can delete payment', 15, 'delete_payment'),
	(60, 'Can view payment', 15, 'view_payment'),
	(61, 'Can add product', 16, 'add_product'),
	(62, 'Can change product', 16, 'change_product'),
	(63, 'Can delete product', 16, 'delete_product'),
	(64, 'Can view product', 16, 'view_product'),
	(65, 'Can add cart checkout', 17, 'add_cartcheckout'),
	(66, 'Can change cart checkout', 17, 'change_cartcheckout'),
	(67, 'Can delete cart checkout', 17, 'delete_cartcheckout'),
	(68, 'Can view cart checkout', 17, 'view_cartcheckout');

-- Dumping structure for table ecommerceforfinal.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.auth_user: ~0 rows (approximately)

-- Dumping structure for table ecommerceforfinal.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.auth_user_groups: ~0 rows (approximately)

-- Dumping structure for table ecommerceforfinal.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.auth_user_user_permissions: ~0 rows (approximately)

-- Dumping structure for table ecommerceforfinal.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.django_admin_log: ~0 rows (approximately)

-- Dumping structure for table ecommerceforfinal.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.django_content_type: ~16 rows (approximately)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(7, 'Home', 'address'),
	(8, 'Home', 'cart'),
	(17, 'Home', 'cartcheckout'),
	(9, 'Home', 'category'),
	(13, 'Home', 'checkout'),
	(10, 'Home', 'feature'),
	(14, 'Home', 'order'),
	(11, 'Home', 'orderdetail'),
	(15, 'Home', 'payment'),
	(16, 'Home', 'product'),
	(12, 'Home', 'slider'),
	(6, 'sessions', 'session');

-- Dumping structure for table ecommerceforfinal.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.django_migrations: ~27 rows (approximately)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'Home', '0001_initial', '2025-10-27 07:49:37.390361'),
	(2, 'contenttypes', '0001_initial', '2025-10-27 07:49:37.420046'),
	(3, 'auth', '0001_initial', '2025-10-27 07:49:37.788478'),
	(4, 'admin', '0001_initial', '2025-10-27 07:49:37.877673'),
	(5, 'admin', '0002_logentry_remove_auto_add', '2025-10-27 07:49:37.886750'),
	(6, 'admin', '0003_logentry_add_action_flag_choices', '2025-10-27 07:49:37.893087'),
	(7, 'contenttypes', '0002_remove_content_type_name', '2025-10-27 07:49:37.950970'),
	(8, 'auth', '0002_alter_permission_name_max_length', '2025-10-27 07:49:37.995671'),
	(9, 'auth', '0003_alter_user_email_max_length', '2025-10-27 07:49:38.018400'),
	(10, 'auth', '0004_alter_user_username_opts', '2025-10-27 07:49:38.025462'),
	(11, 'auth', '0005_alter_user_last_login_null', '2025-10-27 07:49:38.068067'),
	(12, 'auth', '0006_require_contenttypes_0002', '2025-10-27 07:49:38.071284'),
	(13, 'auth', '0007_alter_validators_add_error_messages', '2025-10-27 07:49:38.077731'),
	(14, 'auth', '0008_alter_user_username_max_length', '2025-10-27 07:49:38.123162'),
	(15, 'auth', '0009_alter_user_last_name_max_length', '2025-10-27 07:49:38.170285'),
	(16, 'auth', '0010_alter_group_name_max_length', '2025-10-27 07:49:38.187068'),
	(17, 'auth', '0011_update_proxy_permissions', '2025-10-27 07:49:38.198568'),
	(18, 'auth', '0012_alter_user_first_name_max_length', '2025-10-27 07:49:38.244571'),
	(19, 'sessions', '0001_initial', '2025-10-27 07:49:38.277996'),
	(20, 'Home', '0002_alter_checkout_currency', '2025-10-28 15:50:33.925927'),
	(21, 'Home', '0003_remove_cart_checkout', '2025-10-28 16:32:42.807385'),
	(22, 'Home', '0004_remove_checkout_cart_cart_checkout', '2025-10-28 16:33:37.612882'),
	(23, 'Home', '0005_remove_cart_checkout', '2025-10-28 16:34:09.933710'),
	(24, 'Home', '0006_checkout_cart', '2025-10-28 16:34:50.725324'),
	(25, 'Home', '0007_remove_checkout_cart_cartcheckout', '2025-10-28 16:45:25.367705'),
	(26, 'Home', '0008_remove_cartcheckout_cart_and_more', '2025-10-28 16:48:13.910258'),
	(27, 'Home', '0009_remove_order_order_details_order_orderdetail', '2025-10-28 16:53:14.327512'),
	(28, 'Home', '0010_cart_disable', '2025-10-29 02:07:15.053520'),
	(29, 'Home', '0011_remove_cart_disable', '2025-10-29 02:13:22.869316'),
	(30, 'Home', '0012_remove_payment_address_order_address', '2025-11-01 04:44:43.728057'),
	(31, 'Home', '0013_address_instructions', '2025-11-01 04:49:41.531517'),
	(32, 'Home', '0014_remove_order_address_delete_address', '2025-11-02 07:56:14.629769'),
	(33, 'Home', '0015_cart_disabled', '2025-11-02 09:08:21.290489');

-- Dumping structure for table ecommerceforfinal.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.django_session: ~4 rows (approximately)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('19fumtw8fqm7wadfk6v3ay48c99ojs0z', '.eJyFjs0OgjAQhF_F7JkYyp_C3WiiYqInT83absVIWyz1QAjvbkm4e9udmd1vRrBOkuMSPUI1gkFNUAFE0DXWzCMr2TYJO0rpqO-D4vFNFqYIPo4LK2m-0zIPjiwTkWyRiVSmZaE2GeYZI6EQKVGPcn7jrceWdzhoMh6qIo4jEF_nyIiB-6GbkcfDNSQ1OdGg8XzpdN7V-9XtUp_uwVSvlhb9H3TdmSdM0w9Sn0ih:1vI0a5:Icl1qozFr7zEcQtAFa1GNSWAo29iJ5wQQjOW82xoGTs', '2025-11-23 08:15:25.831536'),
	('98k995n1c6xkm6gficwig0hax1qftj1g', '.eJyFjbEKwjAURX9F3lwkpkZj9qKgVtDJKcSXFxWaNIY4hNJ_t4K767mHewZ4JY29JVADeCtAwUoupFgyJtAQ2dpJJmrnbsTRSbFZc6gg99l0OpriKWRQnLEK8J0SBSw6lzi9wX53nkxPCR8mZB2M_9Jj025nl1N7uE6je3b04_-i8xjuMI4fcPE1iA:1vIKkP:DY01_pBeJSuVuxnClm5H50RyYv8LQ0IHmPmr3vj7SXQ', '2025-11-24 05:47:25.423298'),
	('9gcotfkcwlfj8i2t61pywim8fcj8mzke', '.eJyFzbEOwiAYBOBXMf9sGtoIQmeNi9ahcXAiFH6qSaFIcCBN311M3F2_y90t8IpSzwahXcAZCi3wveWoB4KCcVGzoVG2Joxqi6JhhlDYQpqTmmRQ2aFPpUIqsius3zGi11mmHMog3PpDUYdRP5RP0iv31cuxO236a3e-l9A-J_z5v98q-BHW9QP04zYN:1vFRNh:Rr2fizHdk5Zl8cKi1axXhbDv4d4OiUF8AL9RzDygjSM', '2025-11-16 06:16:01.427939'),
	('ybxc4hevt0otb0ph64nt8s8mwvsku0f9', '.eJyFjb0KwjAYRV9FvrlIDG2N2QKCglShxcEp5FeFJo0hDqH03Y3g7nru4Z4ZXpGrSRugMzjdAAVEpDA7hATRxMq62cp60yKsMbEYt1pDBWlKYuRBZGd8AooRqkC9YzReZZ5yKG9wOvbFdCaqh_CJe-G-dLhezofVwLqO9Wx_K4Z9juY3_iuvg7_DsnwAfxo20w:1vIfJq:GptuFpuavWuvkSkjjIrPUKXDh68ECdOFp3n11DVJ4Sc', '2025-11-25 03:45:22.251289');

-- Dumping structure for table ecommerceforfinal.home_cart
CREATE TABLE IF NOT EXISTS `home_cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(200) NOT NULL,
  `qty` int unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `product_id` int DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Home_cart_product_id_dd6a663b_fk_Home_product_id` (`product_id`),
  CONSTRAINT `Home_cart_product_id_dd6a663b_fk_Home_product_id` FOREIGN KEY (`product_id`) REFERENCES `home_product` (`id`),
  CONSTRAINT `home_cart_chk_1` CHECK ((`qty` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.home_cart: ~4 rows (approximately)
INSERT INTO `home_cart` (`id`, `name`, `image`, `qty`, `price`, `status`, `product_id`, `disabled`) VALUES
	(49, 'Regular Stripped Shirt', 'ZD__4559.jpg', 1, 0.03, 0, 34, 0),
	(50, 'Mini Polo Dresses', 'ZD__3880.jpg', 1, 0.03, 0, 40, 0),
	(51, 'Cropped Fitted T-Shirts', 'ZANDO30.06.20250663.jpg', 1, 0.03, 1, 31, 0);

-- Dumping structure for table ecommerceforfinal.home_cartcheckout
CREATE TABLE IF NOT EXISTS `home_cartcheckout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int DEFAULT NULL,
  `checkout_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Home_cartcheckout_cart_id_400a4ec8_fk_Home_cart_id` (`cart_id`),
  KEY `Home_cartcheckout_checkout_id_cd3688f1_fk_Home_checkout_id` (`checkout_id`),
  CONSTRAINT `Home_cartcheckout_cart_id_400a4ec8_fk_Home_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `home_cart` (`id`),
  CONSTRAINT `Home_cartcheckout_checkout_id_cd3688f1_fk_Home_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `home_checkout` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=688 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.home_cartcheckout: ~38 rows (approximately)
INSERT INTO `home_cartcheckout` (`id`, `cart_id`, `checkout_id`) VALUES
	(686, 51, 679),
	(687, 51, 680);

-- Dumping structure for table ecommerceforfinal.home_category
CREATE TABLE IF NOT EXISTS `home_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ecommerceforfinal.home_category: ~8 rows (approximately)
INSERT INTO `home_category` (`id`, `name`) VALUES
	(7, 'Hoodies'),
	(4, 'Jackets'),
	(2, 'Jeans'),
	(6, 'Pants'),
	(5, 'Shirts'),
	(8, 'Shorts'),
	(3, 'Sweaters'),
	(1, 'T-Shirts');

-- Dumping structure for table ecommerceforfinal.home_checkout
CREATE TABLE IF NOT EXISTS `home_checkout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` varchar(255) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=681 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 

-- Dumping data for table ecommerceforfinal.home_feature: ~4 rows (approximately)
INSERT INTO `home_feature` (`id`, `title`, `image`) VALUES
	(1, 'Regular Wrap Shirts', '7_lc5kla.jpg'),
	(2, 'Bubble Hem Mini Skirts', '8_mapllr.jpg'),
	(3, 'Mini Skirts', '9_b8oq2u.jpg'),
	(4, 'Tube Top', '11_wlhpor.jpg');

-- Dumping structure for table ecommerceforfinal.home_order
CREATE TABLE IF NOT EXISTS `home_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `checkout_id` int NOT NULL,
  `orderdetail_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Home_order_checkout_id_85999d4a_fk_Home_checkout_id` (`checkout_id`),
  KEY `Home_order_orderdetail_id_dc79b972_fk_Home_orderdetail_id` (`orderdetail_id`),
  CONSTRAINT `Home_order_checkout_id_85999d4a_fk_Home_checkout_id` FOREIGN KEY (`checkout_id`) REFERENCES `home_checkout` (`id`),
  CONSTRAINT `Home_order_orderdetail_id_dc79b972_fk_Home_orderdetail_id` FOREIGN KEY (`orderdetail_id`) REFERENCES `home_orderdetail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1335 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 

-- Dumping structure for table ecommerceforfinal.home_orderdetail
CREATE TABLE IF NOT EXISTS `home_orderdetail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Home_orderdetail_product_id_ed4000ed_fk_Home_product_id` (`product_id`),
  CONSTRAINT `Home_orderdetail_product_id_ed4000ed_fk_Home_product_id` FOREIGN KEY (`product_id`) REFERENCES `home_product` (`id`),
  CONSTRAINT `home_orderdetail_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 

-- Dumping structure for table ecommerceforfinal.home_payment
CREATE TABLE IF NOT EXISTS `home_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_account_id` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `currency_type` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Home_payment_order_id_359b36c4_fk_Home_order_id` (`order_id`),
  CONSTRAINT `Home_payment_order_id_359b36c4_fk_Home_order_id` FOREIGN KEY (`order_id`) REFERENCES `home_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 
-- Dumping structure for table ecommerceforfinal.home_product
CREATE TABLE IF NOT EXISTS `home_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(200) NOT NULL,
  `rate` decimal(3,1) NOT NULL,
  `discount_price` decimal(10,2) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Home_product_category_id_89230e2f_fk_Home_category_id` (`category_id`),
  CONSTRAINT `Home_product_category_id_89230e2f_fk_Home_category_id` FOREIGN KEY (`category_id`) REFERENCES `home_category` (`id`),
  CONSTRAINT `home_product_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 

-- Dumping structure for table ecommerceforfinal.home_slider
CREATE TABLE IF NOT EXISTS `home_slider` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `collection` varchar(100) NOT NULL,
  `year` varchar(10) NOT NULL,
  `description` longtext NOT NULL,
  `image` varchar(200) NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
