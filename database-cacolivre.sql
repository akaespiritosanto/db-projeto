CREATE DATABASE cacolivre;
USE cacolivre;

CREATE TABLE users (
  user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(60) NOT NULL,
  address VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(15),
  role ENUM('user', 'admin') NOT NULL DEFAULT 'user',
  created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE ads (
  ad_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  category_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  product_name VARCHAR(200) NOT NULL,
  address VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  product_condition VARCHAR(60) NOT NULL,
  description LONGTEXT NOT NULL,
  active_promotion BOOL NOT NULL DEFAULT FALSE,
  keywords TEXT,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE categories (
  category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(60) NOT NULL,
  sub_category_name VARCHAR(200) NOT NULL
);

CREATE TABLE comments (
  comment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  ad_id INT NOT NULL,
  comment LONGTEXT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id)
);

CREATE TABLE reviews (
  review_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5), -- Warning
  comment TEXT,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE favorites (
  favorite_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  ad_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id)
);

CREATE TABLE saves (
  saved_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  ad_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id)
);

CREATE TABLE notifications (
  notification_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  notification_content TEXT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE chats (
  chat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ad_id INT NOT NULL,
  buyer_id INT NOT NULL,
  seller_id INT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id),
  FOREIGN KEY (buyer_id) REFERENCES users(user_id),
  FOREIGN KEY (seller_id) REFERENCES users(user_id)
);

CREATE TABLE messages (
  message_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  chat_id INT NOT NULL,
  sender_id INT NOT NULL,
  content TEXT NOT NULL,
  sent_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
  FOREIGN KEY (sender_id) REFERENCES users(user_id)
);



