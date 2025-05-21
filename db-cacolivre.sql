CREATE DATABASE cacolivre;
USE cacolivre;

-- Tabela de Utilizadores
CREATE TABLE users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(60) NOT NULL UNIQUE,
  address VARCHAR(255),
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(15),
  role ENUM('user', 'admin') NOT NULL DEFAULT 'user',
  created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Categorias e Subcategorias
CREATE TABLE categories (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(60) NOT NULL,
  sub_category_name VARCHAR(200) NOT NULL
);

-- Anúncios
CREATE TABLE ads (
  ad_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  category_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  product_name VARCHAR(200) NOT NULL,
  address VARCHAR(255) NOT NULL,
  price FLOAT NOT NULL,
  product_condition VARCHAR(60) NOT NULL,
  description LONGTEXT NOT NULL,
  active_promotion BOOLEAN NOT NULL DEFAULT FALSE,
  keywords TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Imagens dos Anúncios
CREATE TABLE ad_images (
  image_id INT PRIMARY KEY AUTO_INCREMENT,
  ad_id INT NOT NULL,
  image_url VARCHAR(255) NOT NULL,
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id)
);

-- Comentários nos Anúncios
CREATE TABLE comments (
  comment_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  ad_id INT NOT NULL,
  comment LONGTEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id)
);

-- Avaliações de Utilizadores
CREATE TABLE reviews (
  review_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,            -- quem faz a avaliação
  reviewed_user_id INT NOT NULL,   -- quem é avaliado
  rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (reviewed_user_id) REFERENCES users(user_id) 
);

-- Atividades do utilizador: favoritos, guardados e visualizados
CREATE TABLE user_activity (
  activity_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  ad_id INT NOT NULL,
  activity_type ENUM('favorite', 'saved', 'viewed') NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id)
);

-- Pesquisas guardadas
CREATE TABLE saved_searches (
  search_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  search_query TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Seguir anúncios
CREATE TABLE follows (
  follow_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  ad_id INT NOT NULL,
  followed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id)
);

-- Notificações
CREATE TABLE notifications (
  notification_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  notification_content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Conversas (Chat) entre compradores e vendedores
CREATE TABLE chats (
  chat_id INT PRIMARY KEY AUTO_INCREMENT,
  ad_id INT NOT NULL,
  buyer_id INT NOT NULL,
  seller_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ad_id) REFERENCES ads(ad_id),
  FOREIGN KEY (buyer_id) REFERENCES users(user_id),
  FOREIGN KEY (seller_id) REFERENCES users(user_id)
);

-- Mensagens dentro dos chats
CREATE TABLE messages (
  message_id INT PRIMARY KEY AUTO_INCREMENT,
  chat_id INT NOT NULL,
  sender_id INT NOT NULL,
  content TEXT NOT NULL,
  sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (chat_id) REFERENCES chats(chat_id),
  FOREIGN KEY (sender_id) REFERENCES users(user_id)
);



INSERT INTO users (user_id, username, address, email, password, phone, role)
VALUES (1, 'joaosilva', 'Rua das Flores 12, Lisboa', 'joao@example.com', 'senha123', '912345678', 'user'),
(2, 'mariaadmin', 'Avenida Central 45, Porto', 'maria@admin.com', 'adminpass', '913456789', 'admin'),
(3, 'user123', 'Rua Nova 100, Braga', 'user123@email.com', 'passuser', '914567890', 'user'),
(4, 'carlospereira', 'Rua do Sol 33, Faro', 'carlos@exemplo.com', 'carlospass', '915678901', 'user');
  
INSERT INTO categories (category_id, category_name, sub_category_name)
VALUES (1, 'Electronics', 'Smartphones'),
(2, 'Electronics', 'Laptops'),
(3, 'Home', 'Furniture'),
(4, 'Vehicles', 'Cars'),
(5, 'Sports', 'Bicycles');
  
INSERT INTO ads (ad_id, user_id, category_id, title, product_name, address, price, product_condition, description, active_promotion, keywords)
VALUES (10, 1, 1, 'iPhone 12 à venda', 'iPhone 12', 'Rua das Flores 12, Lisboa', 500, 'Usado', 'iPhone 12 em ótimo estado.', TRUE, 'iphone, smartphone, apple'),
(11, 2, 2, 'MacBook Pro 2020', 'MacBook Pro', 'Avenida Central 45, Porto', 1200, 'Novo', 'MacBook Pro ainda na caixa.', FALSE, 'macbook, laptop, apple'),
(12, 3, 3, 'Sofá 3 lugares', 'Sofá', 'Rua Nova 100, Braga', 200, 'Usado', 'Sofá confortável, pouco uso.', FALSE, 'sofá, móveis, casa');

INSERT INTO ad_images (image_id, ad_id, image_url)
VALUES (1, 10, 'https://imgsite.com/iphone12.jpg'),
(2, 11, 'https://imgsite.com/macbookpro.jpg'),
(3, 12, 'https://imgsite.com/sofa.jpg');

INSERT INTO comments (comment_id, user_id, ad_id, comment)
VALUES (5, 2, 10, 'Está disponível para entrega em Lisboa?'),
(6, 3, 11, 'Qual o motivo da venda?'),
(7, 1, 12, 'Aceita troca por outro móvel?');

INSERT INTO reviews (review_id, user_id, reviewed_user_id, rating, comment)
VALUES (2, 3, 1, 5, 'Vendedor muito simpático e rápido.'),
(3, 1, 2, 4, 'Boa comunicação, tudo certo.'),
(4, 2, 3, 3, 'Poderia ser mais rápido no envio.');

INSERT INTO user_activity (activity_id, user_id, ad_id, activity_type)
VALUES (4, 1, 10, 'favorite'),
(5, 2, 11, 'saved'),
(6, 3, 12, 'viewed'),
(7, 1, 11, 'favorite');
  
INSERT INTO saved_searches (search_id, user_id, search_query)
VALUES (1, 1, 'iPhone usado Lisboa'),
(2, 2, 'MacBook novo Porto');

INSERT INTO follows (follow_id, user_id, ad_id)
VALUES (1, 1, 10),
(2, 2, 11);
  
INSERT INTO notifications (notification_id, user_id, notification_content)
VALUES (1, 1, 'O seu anúncio foi promovido!'),
(2, 2, 'Recebeu uma nova mensagem.');
  
INSERT INTO chats (chat_id, ad_id, buyer_id, seller_id)
VALUES (1, 10, 2, 1),
(2, 11, 3, 2);

INSERT INTO messages (message_id, chat_id, sender_id, content)
VALUES (1, 1, 2, 'Olá, o iPhone ainda está disponível?'),
(2, 1, 1, 'Sim, está disponível!'),
(3, 2, 3, 'O MacBook ainda tem garantia?');



-- READ

SELECT * FROM users;
SELECT username, email, role FROM users WHERE role = 'admin';
SELECT * FROM categories WHERE category_name = 'Electronics';
SELECT ad_id, title, price FROM ads WHERE price > 100;
SELECT comment, created_at FROM comments WHERE user_id = 1;
SELECT rating, comment FROM reviews WHERE reviewed_user_id = 2;
SELECT activity_type, created_at FROM user_activity WHERE user_id = 3;

-- UPDATE

UPDATE users SET email = 'newemail@example.com' WHERE user_id = 1;
UPDATE users SET role = 'admin' WHERE username = 'user123';
UPDATE categories SET sub_category_name = 'Smartphones' WHERE category_id = 1;
UPDATE ads SET price = 150 WHERE ad_id = 10;
UPDATE comments SET comment = 'Updated comment' WHERE comment_id = 5;
UPDATE reviews SET rating = 4 WHERE review_id = 3;
UPDATE user_activity SET activity_type = 'favorite' WHERE activity_id = 7;

-- DELETE

DELETE FROM users WHERE user_id = 10;
DELETE FROM categories WHERE category_id = 5;
DELETE FROM ads WHERE ad_id = 20;
DELETE FROM ad_images WHERE image_id = 3;
DELETE FROM comments WHERE comment_id = 7;
DELETE FROM reviews WHERE review_id = 2;
DELETE FROM user_activity WHERE activity_id = 4;
