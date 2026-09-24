USE hotel_management;

-- UUID cố định giúp chạy lại seed mà không tạo bản ghi trùng.

-- Q7: lịch sử của khách Nguyễn Minh An
INSERT INTO reservations_by_guest
    (guest_id, check_in, reservation_id, hotel_id, hotel_name,
     room_id, room_number, check_out, total_amount, status)
VALUES
    (cccccccc-cccc-4ccc-8ccc-ccccccccc001, '2026-09-25',
     dddddddd-dddd-4ddd-8ddd-ddddddddd001,
     aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, 'Lotus Riverside Hotel',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb101, '101',
     '2026-09-28', 4350000.00, 'CONFIRMED');
INSERT INTO reservations_by_guest
    (guest_id, check_in, reservation_id, hotel_id, hotel_name,
     room_id, room_number, check_out, total_amount, status)
VALUES
    (cccccccc-cccc-4ccc-8ccc-ccccccccc001, '2026-08-12',
     dddddddd-dddd-4ddd-8ddd-ddddddddd002,
     aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa002, 'Saigon Central Hotel',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb201, '301',
     '2026-08-14', 2200000.00, 'COMPLETED');

-- Q7: lịch sử của khách Trần Ngọc Mai
INSERT INTO reservations_by_guest
    (guest_id, check_in, reservation_id, hotel_id, hotel_name,
     room_id, room_number, check_out, total_amount, status)
VALUES
    (cccccccc-cccc-4ccc-8ccc-ccccccccc002, '2026-09-25',
     dddddddd-dddd-4ddd-8ddd-ddddddddd003,
     aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, 'Lotus Riverside Hotel',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb102, '102',
     '2026-09-27', 2700000.00, 'CHECKED_IN');

-- Q7: lịch sử của khách Lê Hoàng Minh
INSERT INTO reservations_by_guest
    (guest_id, check_in, reservation_id, hotel_id, hotel_name,
     room_id, room_number, check_out, total_amount, status)
VALUES
    (cccccccc-cccc-4ccc-8ccc-ccccccccc003, '2026-10-02',
     dddddddd-dddd-4ddd-8ddd-ddddddddd004,
     aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, 'Lotus Riverside Hotel',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb103, '201',
     '2026-10-04', 4400000.00, 'CONFIRMED');

-- Q8: khách check-in tại Lotus Riverside ngày 25/09/2026
INSERT INTO checkins_by_hotel_date
    (hotel_id, check_in_date, reservation_id, guest_id, guest_name,
     room_id, room_number, check_out_date, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, '2026-09-25',
     dddddddd-dddd-4ddd-8ddd-ddddddddd001,
     cccccccc-cccc-4ccc-8ccc-ccccccccc001, 'Nguyễn Minh An',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb101, '101',
     '2026-09-28', 'CONFIRMED');
INSERT INTO checkins_by_hotel_date
    (hotel_id, check_in_date, reservation_id, guest_id, guest_name,
     room_id, room_number, check_out_date, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, '2026-09-25',
     dddddddd-dddd-4ddd-8ddd-ddddddddd003,
     cccccccc-cccc-4ccc-8ccc-ccccccccc002, 'Trần Ngọc Mai',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb102, '102',
     '2026-09-27', 'CHECKED_IN');
INSERT INTO checkins_by_hotel_date
    (hotel_id, check_in_date, reservation_id, guest_id, guest_name,
     room_id, room_number, check_out_date, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, '2026-10-02',
     dddddddd-dddd-4ddd-8ddd-ddddddddd004,
     cccccccc-cccc-4ccc-8ccc-ccccccccc003, 'Lê Hoàng Minh',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb103, '201',
     '2026-10-04', 'CONFIRMED');

-- Q9: khách check-out tại Lotus Riverside
INSERT INTO checkouts_by_hotel_date
    (hotel_id, check_out_date, reservation_id, guest_id, guest_name,
     room_id, room_number, check_in_date, total_amount, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, '2026-09-27',
     dddddddd-dddd-4ddd-8ddd-ddddddddd003,
     cccccccc-cccc-4ccc-8ccc-ccccccccc002, 'Trần Ngọc Mai',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb102, '102',
     '2026-09-25', 2700000.00, 'CHECKED_IN');
INSERT INTO checkouts_by_hotel_date
    (hotel_id, check_out_date, reservation_id, guest_id, guest_name,
     room_id, room_number, check_in_date, total_amount, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, '2026-09-28',
     dddddddd-dddd-4ddd-8ddd-ddddddddd001,
     cccccccc-cccc-4ccc-8ccc-ccccccccc001, 'Nguyễn Minh An',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb101, '101',
     '2026-09-25', 4350000.00, 'CONFIRMED');
INSERT INTO checkouts_by_hotel_date
    (hotel_id, check_out_date, reservation_id, guest_id, guest_name,
     room_id, room_number, check_in_date, total_amount, status)
VALUES
    (aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001, '2026-10-04',
     dddddddd-dddd-4ddd-8ddd-ddddddddd004,
     cccccccc-cccc-4ccc-8ccc-ccccccccc003, 'Lê Hoàng Minh',
     bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbb103, '201',
     '2026-10-02', 4400000.00, 'CONFIRMED');
