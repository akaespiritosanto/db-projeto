CREATE DATABASE cacolivre;
USE cacolivre;

CREATE TABLE users(
  user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  favorite_id INT NOT NULL, -- associar
  ads_id INT NULL, -- associar
  first_name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  address VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(60) NOT NULL,
  phone INT NULL,
  active_profile_reviews BOOL NOT NULL,
  profile_reviews INT NULL,
  active_favorites BOOL NOT NULL,
  active_ads BOOL NOT NULL,
  active_category BOOL NOT NULL,
  category_name VARCHAR(60) NULL, -- associar
  comment LONGTEXT NULL, -- json
  created TIMESTAMP NOT NULL
);

CREATE TABLE admin(
  admin_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  email 
);

CREATE TABLE categories(
  category_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- associar
  product_id INT NOT NULL, -- associar
  sub_categories VARCHAR (255) NOT NULL,
  other_categories VARCHAR(60) NOT NULL,
  category_name VARCHAR(60) NOT NULL, -- associar
  sub_category_name VARCHAR(200) NOT NULL, -- associar
  active_products BOOL NOT NULL,
  active_promotion BOOL NOT NULL
);

CREATE TABLE chats(
  chat_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  message_id INT NOT NULL, -- associar
  user_id INT NOT NULL, -- associar
  product_id INT NOT NULL, -- associar
  product_chat BOOL NOT NULL
);

CREATE TABLE products(
  product_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  category_id INT NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  product_adress VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  description LONGTEXT NOT NULL
);



