from datetime import date
from uuid import UUID

from fastapi import APIRouter, Query

from db import get_session


router = APIRouter(prefix="/api", tags=["Q7-Q9"])


def _serialize_dates(row, *fields):
    """Đổi cassandra.util.Date sang chuỗi ISO trước khi trả JSON."""
    item = dict(row)
    for field in fields:
        if item.get(field) is not None:
            item[field] = str(item[field])
    return item


@router.get("/q7/guest-reservations")
def reservations_by_guest(
    guest_id: UUID = Query(...),
):
    """Q7 – Xem lịch sử đặt phòng của một khách hàng."""
    rows = get_session().execute(
        """
        SELECT guest_id, check_in, reservation_id, hotel_id, hotel_name,
               room_id, room_number, check_out, total_amount, status
        FROM reservations_by_guest
        WHERE guest_id = %s
        """,
        (guest_id,),
    )
    return [
        _serialize_dates(row, "check_in", "check_out")
        for row in rows
    ]


@router.get("/q8/checkins")
def checkins_by_hotel_date(
    hotel_id: UUID = Query(...),
    check_in_date: date = Query(...),
):
    """Q8 – Xem danh sách khách check-in theo khách sạn và ngày."""
    rows = get_session().execute(
        """
        SELECT hotel_id, check_in_date, reservation_id, guest_id,
               guest_name, room_id, room_number, check_out_date, status
        FROM checkins_by_hotel_date
        WHERE hotel_id = %s AND check_in_date = %s
        """,
        (hotel_id, check_in_date),
    )
    return [
        _serialize_dates(row, "check_in_date", "check_out_date")
        for row in rows
    ]


@router.get("/q9/checkouts")
def checkouts_by_hotel_date(
    hotel_id: UUID = Query(...),
    check_out_date: date = Query(...),
):
    """Q9 – Xem danh sách khách check-out theo khách sạn và ngày."""
    rows = get_session().execute(
        """
        SELECT hotel_id, check_out_date, reservation_id, guest_id,
               guest_name, room_id, room_number, check_in_date,
               total_amount, status
        FROM checkouts_by_hotel_date
        WHERE hotel_id = %s AND check_out_date = %s
        """,
        (hotel_id, check_out_date),
    )
    return [
        _serialize_dates(row, "check_in_date", "check_out_date")
        for row in rows
    ]
