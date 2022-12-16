CREATE DATABASE EcommerceTA;

USE EcommerceTA;

CREATE TABLE person
(
	uid INT PRIMARY KEY AUTO_INCREMENT,
	firstName VARCHAR(50) NULL,
	lastName VARCHAR(50) NULL,
	phone VARCHAR(11) NULL,
	address VARCHAR(90) NULL,
	reference VARCHAR(90) NULL,
	image VARCHAR(250) NULL
);

CREATE TABLE users
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	users VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	passwordd VARCHAR(100) NOT NULL,
	token VARCHAR(256) NULL,
	statuss BOOL NULL DEFAULT 1,
	verified_email BOOL NULL,
	persona_id INT NOT NULL,
	created DATETIME DEFAULT NOW(),
	UNIQUE KEY (email),
	FOREIGN KEY (persona_id) REFERENCES person(uid)
);


CREATE TABLE Home_carousel
(
	uidCarousel INT PRIMARY KEY AUTO_INCREMENT,
	image VARCHAR(256) NULL,
	category VARCHAR(100) NULL
);

CREATE TABLE Category
(
	uidCategory INT PRIMARY KEY AUTO_INCREMENT,
	category VARCHAR(80),
	picture VARCHAR(100) NULL,
	status BOOL DEFAULT 1
);

CREATE TABLE Products
(
	uidProduct INT PRIMARY KEY AUTO_INCREMENT,
	nameProduct VARCHAR(90) NULL,
	description VARCHAR(256) NULL,
	codeProduct VARCHAR(100) NULL,
	stock INT NULL,
	price DOUBLE(18,2) NULL,
	status VARCHAR(80) DEFAULT 'active',
	picture VARCHAR(256) NULL,
	category_id INT,
	FOREIGN KEY (category_id) REFERENCES Category(uidCategory)
);

CREATE TABLE favorite
(
	uidFavorite INT PRIMARY KEY AUTO_INCREMENT,
	product_id INT,
	user_id INT,
	FOREIGN KEY(product_id) REFERENCES Products(uidProduct),
	FOREIGN KEY(user_id) REFERENCES users(persona_id)
);

CREATE TABLE orderBuy
(
	uidOrderBuy INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	receipt VARCHAR(100),
	created_at DATETIME DEFAULT NOW(),
	amount DOUBLE(11,2),
	ongkir DOUBLE(11,2),
	picture VARCHAR(256) DEFAULT '',
	status VARCHAR(80) DEFAULT '0',
	FOREIGN KEY(user_id) REFERENCES users(persona_id)
);

CREATE TABLE orderDetails
(
	uidOrderDetails INT PRIMARY KEY AUTO_INCREMENT,
	orderBuy_id INT,
	product_id INT,
	quantity INT,
	price DOUBLE(11,2),
	FOREIGN KEY(orderBuy_id) REFERENCES orderBuy(uidOrderBuy),
	FOREIGN KEY(product_id) REFERENCES Products(uidProduct)
);

CREATE TABLE keranjang
(
	uidKeranjang INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	receipt VARCHAR(100),
	created_at DATETIME DEFAULT NOW(),
	amount DOUBLE(11,2),
	FOREIGN KEY(user_id) REFERENCES users(persona_id)
);

CREATE TABLE keranjangdetails
(
	uidKeranjangDetails INT PRIMARY KEY AUTO_INCREMENT,
	keranjang_id INT,
	product_id INT,
	quantity INT,
	price DOUBLE(11,2),
	FOREIGN KEY(keranjang_id) REFERENCES keranjang(uidKeranjang),
	FOREIGN KEY(product_id) REFERENCES Products(uidProduct)
);


/*---------------------------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------DATA TEST-----------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------*/


INSERT INTO person (firstName) VALUES 
	('admin');



INSERT INTO users (users, email, passwordd, persona_id) VALUES 
	('admin', 'admin@admin.com', '$2b$10$NJNQxUoxDiiOFXwFfcXr4e5DX83/DaRKhS7PSBPmSB/wmUl84YnyS', '1');


INSERT INTO Category (category) VALUES 
	('Beauty'),
	('Technology'),
	('Home Appliances');
	

INSERT INTO Products (nameProduct, description, codeProduct, stock, price, picture, category_id) VALUES 
	('Sabun Charcoal', 'Dengan standar Charcoal Jepang. Sangat cocok untuk kebersihan muda dan membantu mengatasi masalah wajah anda', '001Sabun Charcoal', '10', '10000', 'portfolio-1.png', '1'),
	('Body Lotion', 'Dengan extract kacang-kacangan bukan berbasis alkohol. Sangat lembut di kulit dan kelembapan kulit, serta bertahan lebih lama', '002Body Lotion', '10', '10000', 'portfolio-2.png', '1'),
	('Lebah Madu', 'Dengan Nano terbaru, sehingga partikel propolis lebih lembut di kulit. Untuk khasiat dan efek yang lebih sempurna dibandingkan propolis sejenis', '003Lebah Madu', '10', '10000', 'portfolio-3.png', '1'),
	('Kartu Penghemat BBM', 'Dengan teknologi ION Standar German. Penggunaan cukup di tempel dan bertahan hingga 3 tahun', '004Kartu Penghemat BBM', '10', '10000', 'portfolio-4.png', '2'),
	('Filter Rumah Tangga', 'Simle dan sehat. Dengan teknologi bola-bola keramik NANO dan anti bakteri serta jamur dengan standar Singapura', '005Filter Rumah Tangga', '10', '10000', 'portfolio-5.png', '3');


INSERT INTO Home_carousel (image, category) VALUES 
	('portfolio-4.png', 'home1'),
	('portfolio-5.png', 'home2');












