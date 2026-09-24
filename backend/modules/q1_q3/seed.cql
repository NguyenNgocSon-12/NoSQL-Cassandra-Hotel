USE hotel_management;

-- UUID cố định giúp seed có thể chạy lại mà không tạo bản ghi trùng.

-- Q1: khách sạn theo địa điểm
INSERT INTO hotels_by_location
    (location, hotel_id, hotel_name, address, phone,
     star_rating, description)
VALUES
    ('Quận 1, TP.HCM', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001,
     'Lotus Riverside Hotel', '12 Tôn Đức Thắng, Quận 1, TP.HCM',
     '028-3822-8899', 5, 'Khách sạn ven sông, gần trung tâm và phố đi bộ.');
INSERT INTO hotels_by_location
    (location, hotel_id, hotel_name, address, phone,
     star_rating, description)
VALUES
    ('Quận 1, TP.HCM', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa002,
     'Saigon Central Hotel', '88 Lê Thánh Tôn, Quận 1, TP.HCM',
     '028-3914-6688', 4, 'Khách sạn trung tâm, thuận tiện tham quan và công tác.');
INSERT INTO hotels_by_location
    (location, hotel_id, hotel_name, address, phone,
     star_rating, description)
VALUES
    ('Đà Lạt', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa003,
     'Da Lat Pine Resort', '25 Trần Quốc Toản, Đà Lạt, Lâm Đồng',
     '0263-355-7788', 4, 'Khu nghỉ dưỡng gần Hồ Xuân Hương và vườn thông.');
INSERT INTO hotels_by_location
    (location, hotel_id, hotel_name, address, phone,
     star_rating, description)
VALUES
    ('Gần Chợ Bến Thành', aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa002,
     'Saigon Central Hotel', '88 Lê Thánh Tôn, Quận 1, TP.HCM',
     '028-3914-6688', 4, 'Cách Chợ Bến Thành khoảng 700 mét.');

-- Q2: phòng theo khách sạn và loại phòng
INSERT INTO rooms_by_hotel_type
    (hotel_id, room_type, room_number, room_id,
     floor, price, capacity, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, 'Deluxe', '101',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb101, 1, 1450000.00, 2, 'OCCUPIED');
INSERT INTO rooms_by_hotel_type
    (hotel_id, room_type, room_number, room_id,
     floor, price, capacity, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, 'Deluxe', '102',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb102, 1, 1350000.00, 2, 'AVAILABLE');
INSERT INTO rooms_by_hotel_type
    (hotel_id, room_type, room_number, room_id,
     floor, price, capacity, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, 'Suite', '201',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb103, 2, 2200000.00, 3, 'AVAILABLE');
INSERT INTO rooms_by_hotel_type
    (hotel_id, room_type, room_number, room_id,
     floor, price, capacity, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa002, 'Deluxe', '301',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb201, 3, 1100000.00, 2, 'AVAILABLE');
INSERT INTO rooms_by_hotel_type
    (hotel_id, room_type, room_number, room_id,
     floor, price, capacity, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa003, 'Bungalow', 'B01',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb301, 1, 1800000.00, 4, 'AVAILABLE');

-- Q3: tiện ích theo phòng
INSERT INTO amenities_by_room
    (hotel_id, room_id, amenity_name, description, price)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001,
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb101,
     'Bữa sáng', 'Buffet sáng cho hai khách', 250000.00);
INSERT INTO amenities_by_room
    (hotel_id, room_id, amenity_name, description, price)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001,
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb101,
     'Minibar', 'Nước suối miễn phí và đồ uống tính phí', 0.00);
INSERT INTO amenities_by_room
    (hotel_id, room_id, amenity_name, description, price)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001,
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb101,
     'Wi-Fi', 'Wi-Fi tốc độ cao miễn phí', 0.00);
INSERT INTO amenities_by_room
    (hotel_id, room_id, amenity_name, description, price)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001,
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb102,
     'Bữa sáng', 'Buffet sáng cho hai khách', 250000.00);
INSERT INTO amenities_by_room
    (hotel_id, room_id, amenity_name, description, price)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001,
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb103,
     'Đưa đón sân bay', 'Xe riêng một chiều từ sân bay', 450000.00);
INSERT INTO amenities_by_room
    (hotel_id, room_id, amenity_name, description, price)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa002,
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb201,
     'Bàn làm việc', 'Bàn và ghế làm việc công thái học', 0.00);
INSERT INTO amenities_by_room
    (hotel_id, room_id, amenity_name, description, price)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa003,
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb301,
     'Lò sưởi', 'Lò sưởi điện trong bungalow', 150000.00);
