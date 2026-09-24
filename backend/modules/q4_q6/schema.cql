CREATE KEYSPACE IF NOT EXISTS hotel_management
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
};

USE hotel_management;

-- Q4 – Tìm phòng trống theo khách sạn và ngày
CREATE TABLE IF NOT EXISTS available_rooms_by_hotel_date (
    hotel_id text,
    stay_date date,
    room_number text,
    room_id uuid,
    room_type text,
    price decimal,
    is_available boolean,
    PRIMARY KEY ((hotel_id, stay_date), room_number)
);

-- Q5 – Xem lịch đặt của một phòng
CREATE TABLE IF NOT EXISTS reservations_by_room (
    hotel_id text,
    room_id uuid,
    check_in date,
    reservation_id uuid,
    check_out date,
    guest_id uuid,
    guest_name text,
    status text,
    PRIMARY KEY ((hotel_id, room_id), check_in, reservation_id)
) WITH CLUSTERING ORDER BY (check_in DESC);

-- Q6 – Tra cứu booking bằng mã xác nhận
CREATE TABLE IF NOT EXISTS reservations_by_confirmation (
    confirmation_code text PRIMARY KEY,
    reservation_id uuid,
    hotel_id text,
    hotel_name text,
    guest_id uuid,
    guest_name text,
    room_id uuid,
    room_number text,
    check_in date,
    check_out date,
    status text,
    total_amount decimal
);
