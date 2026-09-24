USE hotel_management;

-- UUID cố định giúp chạy lại seed mà không tạo dữ liệu trùng.

-- Q4: tình trạng phòng theo từng ngày
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H001', '2026-09-25', '101', 11111111-1111-4111-8111-111111111101, 'Deluxe King', 1450000.00, false);
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H001', '2026-09-25', '102', 11111111-1111-4111-8111-111111111102, 'Deluxe Twin', 1350000.00, true);
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H001', '2026-09-25', '201', 11111111-1111-4111-8111-111111111103, 'River Suite', 2200000.00, true);
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H001', '2026-09-26', '101', 11111111-1111-4111-8111-111111111101, 'Deluxe King', 1450000.00, false);
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H001', '2026-09-26', '102', 11111111-1111-4111-8111-111111111102, 'Deluxe Twin', 1350000.00, true);
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H001', '2026-09-26', '201', 11111111-1111-4111-8111-111111111103, 'River Suite', 2200000.00, true);
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H002', '2026-09-25', '301', 11111111-1111-4111-8111-111111111201, 'Superior', 1100000.00, true);
INSERT INTO available_rooms_by_hotel_date
    (hotel_id, stay_date, room_number, room_id, room_type, price, is_available)
VALUES
    ('H002', '2026-09-25', '302', 11111111-1111-4111-8111-111111111202, 'Executive', 1750000.00, true);

-- Q5: lịch đặt theo phòng
INSERT INTO reservations_by_room
    (hotel_id, room_id, check_in, reservation_id, check_out,
     guest_id, guest_name, status)
VALUES
    ('H001', 11111111-1111-4111-8111-111111111101, '2026-10-05',
     22222222-2222-4222-8222-222222222202, '2026-10-07',
     33333333-3333-4333-8333-333333333302, 'Trần Ngọc Mai', 'CANCELLED');
INSERT INTO reservations_by_room
    (hotel_id, room_id, check_in, reservation_id, check_out,
     guest_id, guest_name, status)
VALUES
    ('H001', 11111111-1111-4111-8111-111111111101, '2026-09-25',
     22222222-2222-4222-8222-222222222201, '2026-09-28',
     33333333-3333-4333-8333-333333333301, 'Nguyễn Minh An', 'CONFIRMED');
INSERT INTO reservations_by_room
    (hotel_id, room_id, check_in, reservation_id, check_out,
     guest_id, guest_name, status)
VALUES
    ('H002', 11111111-1111-4111-8111-111111111201, '2026-09-26',
     22222222-2222-4222-8222-222222222203, '2026-09-27',
     33333333-3333-4333-8333-333333333303, 'Lê Hoàng Minh', 'CONFIRMED');

-- Q6: cùng các booking trên, tối ưu cho tra cứu mã xác nhận
INSERT INTO reservations_by_confirmation
    (confirmation_code, reservation_id, hotel_id, hotel_name,
     guest_id, guest_name, room_id, room_number,
     check_in, check_out, status, total_amount)
VALUES
    ('CNF-Q456-001', 22222222-2222-4222-8222-222222222201,
     'H001', 'Lotus Riverside Hotel',
     33333333-3333-4333-8333-333333333301, 'Nguyễn Minh An',
     11111111-1111-4111-8111-111111111101, '101',
     '2026-09-25', '2026-09-28', 'CONFIRMED', 4350000.00);
INSERT INTO reservations_by_confirmation
    (confirmation_code, reservation_id, hotel_id, hotel_name,
     guest_id, guest_name, room_id, room_number,
     check_in, check_out, status, total_amount)
VALUES
    ('CNF-Q456-002', 22222222-2222-4222-8222-222222222202,
     'H001', 'Lotus Riverside Hotel',
     33333333-3333-4333-8333-333333333302, 'Trần Ngọc Mai',
     11111111-1111-4111-8111-111111111101, '101',
     '2026-10-05', '2026-10-07', 'CANCELLED', 2900000.00);
INSERT INTO reservations_by_confirmation
    (confirmation_code, reservation_id, hotel_id, hotel_name,
     guest_id, guest_name, room_id, room_number,
     check_in, check_out, status, total_amount)
VALUES
    ('CNF-Q456-003', 22222222-2222-4222-8222-222222222203,
     'H002', 'Saigon Central Hotel',
     33333333-3333-4333-8333-333333333303, 'Lê Hoàng Minh',
     11111111-1111-4111-8111-111111111201, '301',
     '2026-09-26', '2026-09-27', 'CONFIRMED', 1100000.00);
