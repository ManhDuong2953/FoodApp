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

CREATE TABLE FavoritesFood (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    food_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (food_id) REFERENCES Food(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    food_id INT,
    user_id INT,
    order_datetime DATETIME DEFAULT CURRENT_TIMESTAMP, 
    quantity INT default 1,
    total_price DECIMAL(10, 2) default 0.0,
    FOREIGN KEY (food_id) REFERENCES Food(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    food_id INT,
    user_id INT,
    comment TEXT ,
    rate INT default 5,
    reviews_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (food_id) REFERENCES Food(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE ON UPDATE CASCADE
);



INSERT INTO Food (name, price, ingredients, description, img_thumbnail)
VALUES
('Hamburger', 12.99, 'Beef patty, cheese, lettuce, tomato, onion', 'A classic American burger made with a juicy beef patty, melted cheese, and all your favorite toppings.', 'https://e1.pxfuel.com/desktop-wallpaper/609/28/desktop-wallpaper-veggie-burger-burger.jpg'),
('Pizza', 14.99, 'Tomato sauce, mozzarella cheese, pepperoni', 'A delicious pizza topped with your favorite toppings.', 'https://truongcaodangnauan.edu.vn/test_disk/photos/shares/mon-ngon-moi-ngay/n%E1%BA%A5u%20%C4%83n/b%C3%A1nh%20pizza/cach-lam-banh-pizza-tai-nha-3.jpg'),
('Tacos', 10.99, 'Ground beef, shredded cheese, lettuce, tomato, salsa', 'Delicious tacos made with your favorite toppings.', 'https://i0.wp.com/www.onceuponachef.com/images/2023/08/Beef-Tacos.jpg?resize=760%2C570&ssl=1'),
('Burrito', 11.99, 'Rice, beans, cheese, meat, salsa, sour cream', 'A hearty burrito filled with your favorite ingredients.', 'https://cdn.britannica.com/13/234013-050-73781543/rice-and-chorizo-burrito.jpg'),
('Sushi', 15.99, 'Rice, vinegar, sugar, salt, seaweed, fish, vegetables', 'Fresh and delicious sushi made with the finest ingredients.', 'https://vcdn-dulich.vnecdn.net/2021/09/02/3-9194-1630568961.jpg'),
('Salad', 9.99, 'Mixed greens, tomatoes, cucumbers, carrots, dressing', 'A healthy and refreshing salad made with fresh ingredients.', 'https://www.wellplated.com/wp-content/uploads/2021/05/Delicious-Fruit-Salad-500x500.jpg'),
('Soup', 8.99, 'Broth, vegetables, meat', 'A warm and comforting soup made with your favorite ingredients.', 'https://kristineskitchenblog.com/wp-content/uploads/2022/02/minestrone-soup-recipe-22.jpg'),
('Sandwich', 10.99, 'Bread, meat, cheese, vegetables', 'A delicious sandwich made with your favorite ingredients.', 'https://www.southernliving.com/thmb/UW4kKKL-_M3WgP7pkL6Pb6lwcgM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Ham_Sandwich_011-1-49227336bc074513aaf8fdbde440eafe.jpg'),
('Dessert', 7.99, 'Cake, ice cream, pie', 'A sweet treat to end your meal.', 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/dessert-main-image-molten-cake-0fbd4f2.jpg?resize=768,574')
