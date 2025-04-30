CREATE DATABASE cacolivre;
USE cacolivre;

CREATE TABLE users(
  user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL,
  last_name VARCHAR(60) NOT NULL,
  address VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone INT NULL,
  profile_reviews INT NULL,
  active_favorites BOOL NOT NULL,
  active_ads BOOL NOT NULL,
  active_categories BOOL NOT NULL,
  favorite_id INT NOT NULL, -- associar
  ads_id INT NULL, -- associar
  category_name VARCHAR(60) NULL, -- associar
  comment LONGTEXT NULL, -- json
  created TIMESTAMP NOT NULL
);



CREATE TABLE categories(
  category_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- associar
  category_name VARCHAR(60) NOT NULL, -- associar
  product_id INT NULL, -- associar
  active_products BOOL NOT NULL,
  
);
