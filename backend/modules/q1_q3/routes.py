from uuid import UUID

from fastapi import APIRouter, Query

from db import get_session


router = APIRouter(prefix="/api", tags=["Q1-Q3"])


@router.get("/q1/hotels")
def hotels_by_location(
    location: str = Query(..., min_length=1),
):
    """Q1 – Tìm khách sạn theo khu vực hoặc địa điểm."""
    rows = get_session().execute(
        """
        SELECT location, hotel_id, hotel_name, address,
               phone, star_rating, description
        FROM hotels_by_location
        WHERE location = %s
        """,
        (location,),
    )
    return list(rows)


@router.get("/q2/rooms")
def rooms_by_hotel_type(
    hotel_id: UUID = Query(...),
    room_type: str = Query(..., min_length=1),
):
    """Q2 – Tìm phòng theo khách sạn và loại phòng."""
    rows = get_session().execute(
        """
        SELECT hotel_id, room_type, room_number, room_id,
               floor, price, capacity, status
        FROM rooms_by_hotel_type
        WHERE hotel_id = %s AND room_type = %s
        """,
        (hotel_id, room_type),
    )
    return list(rows)


@router.get("/q3/room-amenities")
def amenities_by_room(
    hotel_id: UUID = Query(...),
    room_id: UUID = Query(...),
):
    """Q3 – Xem toàn bộ tiện ích của một phòng."""
    rows = get_session().execute(
        """
        SELECT hotel_id, room_id, amenity_name, description, price
        FROM amenities_by_room
        WHERE hotel_id = %s AND room_id = %s
        """,
        (hotel_id, room_id),
    )
    return list(rows)
