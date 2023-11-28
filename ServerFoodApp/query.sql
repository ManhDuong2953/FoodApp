CREATE DATABASE FoodApp;

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
    price DECIMAL(10, 2) default 0,
    ingredients TEXT,
    description TEXT,
    img_thumbnail VARCHAR(1000),
    total_orders int default 0
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

INSERT INTO Users (name, phone_number, address, password, avatar_thumbnail) VALUES
    ('Dương Văn Mạnh', '123456789', 'Đức Thắng, Bắc Từ Liêm, Hà Nội', '123', 'https://photo-cms-tinnhanhchungkhoan.epicdn.me/w1200/Uploaded/2023/xpivpivo/2018_11_19/matt-smith-yuanta_ZHUO.jpg');


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
('Dessert', 7.99, 'Cake, ice cream, pie', 'A sweet treat to end your meal.', 'https://images.immediate.co.uk/production/volatile/sites/30/2020/08/dessert-main-image-molten-cake-0fbd4f2.jpg?resize=768,574'),
('Phở', 8.99, 'Bún, nước dùng, thịt bò hoặc gà, rau mùi', 'Món súp mì truyền thống của Việt Nam bao gồm nước dùng, bún, rau mùi và thịt, thường là thịt bò hoặc gà.', 'https://static.vinwonders.com/production/pho-bo-ha-noi.jpeg'),
('Cháo Gà', 5.99, 'Cháo, thịt gà, hành, nước dùng', 'Cháo với thịt gà, một bữa sáng hoặc bữa ăn dễ chịu và bổ dưỡng thường được thưởng thức khi không khỏe.', 'https://cdn.statically.io/img/gachaybo.com/f=auto/wp-content/uploads/2020/11/chao-ga-8.jpg'),
('Bún Đậu Mắm Tôm', 9.99, 'Bún, đậu hủ chiên, mắm tôm, rau sống', 'Bún với đậu hủ chiên, mắm tôm và các nguyên liệu khác, một món ăn vỉa hè ngon và đặc sắc.', 'https://vcdn-giadinh.vnecdn.net/2021/01/15/bun-1-5687-1610696220.jpg'),
('Nem Nướng', 6.99, 'Thịt nướng, bánh tráng, rau sống', 'Làm từ thịt nướng thơm ngon, được phục vụ cùng với rau sống và bánh tráng để cuốn, một món ăn ngon và thú vị.', 'https://i.ytimg.com/vi/I_n1IQggIQ4/maxresdefault.jpg'),
('Cơm Rang Dưa Bò', 7.99, 'Cơm, thịt bò, dưa leo muối', 'Cơm chiên với thịt bò và dưa leo muối, mang lại sự kết hợp ngon miệng của hương vị và cấu trúc.', 'https://cdn.tgdd.vn/Files/2022/01/06/1409476/cach-lam-com-rang-dua-bo-tai-nha-ngon-nhu-ngoai-hang-202201061628031278.jpg'),
('Bún Bò Huế', 10.99, 'Bún, thịt bò, bún lá, rau sống', 'Mì Quảng cay nồng từ thành phố Huế, nổi tiếng với nước dùng đậm đà và phong cách ẩm thực độc đáo.', 'https://i.ytimg.com/vi/A_o2qfaTgKs/maxresdefault.jpg'),
('Miến Gà', 8.49, 'Miến, thịt gà, nước dùng, rau sống', 'Súp miến trong suốt với thịt gà băm, một sự chọn lựa nhẹ nhàng và tươi mới.', 'https://i.ytimg.com/vi/ko0YRS3Tc2I/maxresdefault.jpg'),
('Xôi Xéo', 4.99, 'Xôi, đậu xanh, hành phi', 'Xôi ngọt với đậu xanh và hành phi, một món tráng miệng Việt Nam phổ biến hoặc ăn vặt.', 'https://statics.vinpearl.com/xoi-xeo-01%20(2)_1632322118.jpg'),
('Gà Chiên', 9.49, 'Thịt gà, bột chiên giòn', 'Gà chiên giòn, một món ăn kinh điển thưởng thức với lớp vỏ giòn và nhân nước miếng.', 'https://cdn.tgdd.vn/Files/2017/03/22/963765/cach-lam-ga-ran-thom-ngon-8_760x450.jpg'),
('Nước Mía', 3.99, 'Nước mía', 'Nước mía tươi, một đồ uống ngọt và sảng khoái thường được phục vụ đá.', 'https://cdn.tgdd.vn/2021/08/CookProduct/thumb-1200x676-7.jpg'),
('Bún Ốc', 8.99, 'Bún, ốc, nước dùng thơm', 'Bún với ốc trong nước dùng thơm ngon, một món ăn độc đáo cho những người thích thử thách.', 'https://danviet.mediacdn.vn/296231569849192448/2022/8/24/11-16613326196911429545693.jpg'),
('Phở Cuốn', 6.99, 'Bánh tráng, thịt bò, bún, rau sống', 'Cuộn bánh tráng với các thành phần của phở truyền thống, một lựa chọn nhẹ và ngon.', 'https://nauco29.com/uploads/content/pho-cuon.jpg'),
('Bún Chả', 7.49, 'Bún, thịt nướng, nước mắm', 'Bún với thịt nướng, rau sống và nước mắm, một món ăn vỉa hè phổ biến và ngon miệng.', 'https://kipor.vn//upload/images/lam-bun-cha-bang-noi-chien-khong-dau-6.jpg'),
('Bánh Xèo', 5.99, 'Bánh xèo, tôm, thịt, giá, rau sống', 'Bánh xèo Việt Nam giòn rụm với tôm, thịt, giá và rau sống.', 'https://sunhouse.com.vn/pic/news/1295_cach_lam_banh_xeo_4.jpg'),
('Gỏi Cuốn', 6.49, 'Bánh tráng, tôm, rau sống, bún', 'Cuốn bánh tráng tươi với tôm, rau sống, bún và nước mắm phục vụ cùng sốt lạc.', 'https://fptshop.com.vn/Uploads/Originals/2023/10/23/638336957766719361_cach-lam-goi-cuon.jpg'),
('Hoa Quả Dầm', 4.99, 'Trái cây tươi', 'Salad hoa quả trộn, một lựa chọn tươi mới và lành mạnh thường được phục vụ với nước mắm ngọt và chua.', 'https://toplist.vn/images/800px/cach-lam-hoa-qua-dam-kieu-1-671726.jpg'),
('Cafee Trứng', 5.99, 'Cà phê, trứng gà, đường', 'Cà phê trứng, một loại cà phê Việt Nam đặc trưng được trang trí bởi lớp bọt trứng ngọt.', 'https://toplist.vn/images/800px/-720817.jpg'),
('Bún Riêu', 7.99, 'Bún, riêu, thịt gà, cua', 'Súp bún riêu với nước dùng chua ngọt, bún và các nguyên liệu hải sản khác.', 'https://tiki.vn/blog/wp-content/uploads/2023/07/thumb.jpeg'),
('Thịt Kho Tàu', 9.99, 'Thịt ba rọi, nước sốt caramen', 'Thịt ba rọi kho tộ trong nước sốt caramen thơm ngon, một món ăn truyền thống và ấm áp của người Việt.', 'https://tiki.vn/blog/wp-content/uploads/2023/02/thit-kho-tau-2-.jpg'),
('Chè Thập Cẩm', 4.49, 'Đậu đỏ, đậu xanh, trái cây, thạch', 'Chè hỗn hợp với đủ loại đậu, trái cây và thạch, một lựa chọn tráng miệng phổ biến.', 'https://satovietnhat.com.vn/Upload/images/nau-che-cung-sato-2.jpg');


