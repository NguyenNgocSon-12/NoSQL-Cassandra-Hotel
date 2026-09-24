from datetime import date
from uuid import UUID

from fastapi import APIRouter, HTTPException, Query

from db import get_session


router = APIRouter(prefix="/api", tags=["Q4-Q6"])


def _serialize_dates(row, *fields):
    """Cassandra Date không phải datetime.date; đổi sang chuỗi ISO cho JSON."""
    item = dict(row)
    for field in fields:
        if item.get(field) is not None:
            item[field] = str(item[field])
    return item


@router.get("/q4/available-rooms")
def available_rooms(
    hotel_id: str = Query(..., min_length=1),
    stay_date: date = Query(...),
):
    """Q4 – Tìm phòng còn trống theo khách sạn và một ngày lưu trú."""
    rows = get_session().execute(
        """
        SELECT hotel_id, stay_date, room_number, room_id,
               room_type, price, is_available
        FROM available_rooms_by_hotel_date
        WHERE hotel_id = %s AND stay_date = %s
        """,
        (hotel_id, stay_date),
    )
    return [
        _serialize_dates(row, "stay_date")
        for row in rows
        if row["is_available"]
    ]


@router.get("/q5/room-reservations")
def room_reservations(
    hotel_id: str = Query(..., min_length=1),
    room_id: UUID = Query(...),
):
    """Q5 – Xem lịch đặt của một phòng, mới nhất trước."""
    rows = get_session().execute(
        """
        SELECT hotel_id, room_id, check_in, reservation_id,
               check_out, guest_id, guest_name, status
        FROM reservations_by_room
        WHERE hotel_id = %s AND room_id = %s
        """,
        (hotel_id, room_id),
    )
    return [
        _serialize_dates(row, "check_in", "check_out")
        for row in rows
    ]


@router.get("/q6/reservations/{confirmation_code}")
def reservation_by_confirmation(confirmation_code: str):
    """Q6 – Tra cứu một booking bằng mã xác nhận."""
    row = get_session().execute(
        """
        SELECT confirmation_code, reservation_id, hotel_id, hotel_name,
               guest_id, guest_name, room_id, room_number,
               check_in, check_out, status, total_amount
        FROM reservations_by_confirmation
        WHERE confirmation_code = %s
        """,
        (confirmation_code,),
    ).one()
    if row is None:
        raise HTTPException(
            status_code=404,
            detail="Không tìm thấy booking với mã xác nhận này",
        )
    return _serialize_dates(row, "check_in", "check_out")
