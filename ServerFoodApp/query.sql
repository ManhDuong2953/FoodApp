CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    password VARCHAR(255),
    avatar_thumbnail VARCHAR(1000)
);

CREATE TABLE Food (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    ingredients TEXT,
    description TEXT,
    img_thumbnail VARCHAR(1000)
);


CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    food_id INT,
    user_id INT,
    order_datetime DATETIME DEFAULT CURRENT_TIMESTAMP ON DELETE CASCADE ON UPDATE CASCADE,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (food_id) REFERENCES Food(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    food_id INT,
    user_id INT,
    comment TEXT,
    rate INT,
    reviews_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (food_id) REFERENCES Food(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE
);
