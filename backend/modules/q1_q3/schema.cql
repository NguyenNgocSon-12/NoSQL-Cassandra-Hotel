CREATE KEYSPACE IF NOT EXISTS hotel_management
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
};

USE hotel_management;

-- Q1 – Tìm khách sạn theo khu vực hoặc địa điểm
CREATE TABLE IF NOT EXISTS hotels_by_location (
    location text,
    hotel_id uuid,
    hotel_name text,
    address text,
    phone text,
    star_rating int,
    description text,
    PRIMARY KEY (location, hotel_id)
);

-- Q2 – Tìm phòng theo khách sạn và loại phòng
CREATE TABLE IF NOT EXISTS rooms_by_hotel_type (
    hotel_id uuid,
    room_type text,
    room_number text,
    room_id uuid,
    floor int,
    price decimal,
    capacity int,
    status text,
    PRIMARY KEY ((hotel_id, room_type), room_number)
);

-- Q3 – Xem tiện ích của một phòng
CREATE TABLE IF NOT EXISTS amenities_by_room (
    hotel_id uuid,
    room_id uuid,
    amenity_name text,
    description text,
    price decimal,
    PRIMARY KEY ((hotel_id, room_id), amenity_name)
);
