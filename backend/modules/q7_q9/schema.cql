CREATE KEYSPACE IF NOT EXISTS hotel_management
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
};

USE hotel_management;

-- Q7 – Xem lịch sử đặt phòng của khách hàng
CREATE TABLE IF NOT EXISTS reservations_by_guest (
    guest_id uuid,
    check_in date,
    reservation_id uuid,
    hotel_id uuid,
    hotel_name text,
    room_id uuid,
    room_number text,
    check_out date,
    total_amount decimal,
    status text,
    PRIMARY KEY (guest_id, check_in, reservation_id)
) WITH CLUSTERING ORDER BY (check_in DESC);

-- Q8 – Xem danh sách khách check-in theo khách sạn và ngày
CREATE TABLE IF NOT EXISTS checkins_by_hotel_date (
    hotel_id uuid,
    check_in_date date,
    reservation_id uuid,
    guest_id uuid,
    guest_name text,
    room_id uuid,
    room_number text,
    check_out_date date,
    status text,
    PRIMARY KEY ((hotel_id, check_in_date), reservation_id)
);

-- Q9 – Xem danh sách khách check-out theo khách sạn và ngày
CREATE TABLE IF NOT EXISTS checkouts_by_hotel_date (
    hotel_id uuid,
    check_out_date date,
    reservation_id uuid,
    guest_id uuid,
    guest_name text,
    room_id uuid,
    room_number text,
    check_in_date date,
    total_amount decimal,
    status text,
    PRIMARY KEY ((hotel_id, check_out_date), reservation_id)
);
