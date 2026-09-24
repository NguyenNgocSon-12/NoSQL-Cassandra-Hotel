# Hotel Management — Cassandra + FastAPI

Project được tổ chức cho **3 thành viên**, mỗi người phụ trách trọn vẹn 3 query.
Mục tiêu là hạn chế sửa chung file, dễ merge trên GitHub và dễ xác định lỗi thuộc
module nào.

Hiện project đã có hai module **Q4–Q6** và **Q7–Q9**. Q1–Q3 chưa triển khai.

## 1. Cấu trúc project

```text
hotel-app/
├── backend/
│   ├── main.py                    # đăng ký router của các thành viên
│   ├── db.py                      # kết nối Cassandra dùng chung
│   ├── .env.example
│   ├── requirements.txt
│   └── modules/
│       ├── q4_q6/                 # schema, seed và API riêng của Q4–Q6
│       └── q7_q9/                 # schema, seed và API riêng của Q7–Q9
├── frontend/
│   ├── index.html                 # dashboard chứa các tab Q1–Q9
│   ├── q4.html                    # chỉ chứa giao diện Q4
│   ├── q5.html                    # chỉ chứa giao diện Q5
│   ├── q6.html                    # chỉ chứa giao diện Q6
│   ├── q7.html                    # mỗi file chỉ chứa một query
│   ├── q8.html
│   └── q9.html
└── compose.yml
```

### Quy ước ownership

| Thành viên | Backend module | Frontend sở hữu |
|---|---|---|
| Người 1 | `backend/modules/q1_q3/` | `q1.html`, `q2.html`, `q3.html` |
| Người 2 | `backend/modules/q4_q6/` | `q4.html`, `q5.html`, `q6.html` |
| Người 3 | `backend/modules/q7_q9/` | `q7.html`, `q8.html`, `q9.html` |

Mỗi module backend phải có đúng ba file chính:

- `schema.cql`: `CREATE KEYSPACE IF NOT EXISTS`, `USE`, và các bảng của module.
- `seed.cql`: `USE` và dữ liệu mẫu có ID cố định để chạy lại không tạo bản ghi trùng.
- `routes.py`: một `APIRouter` chứa đúng các API của ba query được giao.

Các file dùng chung cần sửa ít nhất có thể:

- `backend/main.py`: thêm import router và một dòng `app.include_router(...)`.
- `frontend/index.html`: bật ba tab và trỏ mỗi tab tới HTML tương ứng.
- `backend/db.py`: chỉ sửa khi cả nhóm thống nhất thay đổi cách kết nối/keyspace.

## 2. Yêu cầu môi trường

- Docker Desktop và Docker Compose v2.
- Python 3.10–3.12. Không nên dùng Python 3.14 với `cassandra-driver==3.29.1`.

## 3. Chạy Cassandra và tự động nạp module

Tại thư mục gốc project:

```bash
docker compose up -d
docker compose ps -a
```

Docker sẽ:

1. Khởi động Cassandra ở `localhost:9042`.
2. Chờ Cassandra healthy.
3. Chạy lần lượt mọi `backend/modules/*/schema.cql`.
4. Chạy lần lượt mọi `backend/modules/*/seed.cql`.

`cassandra-init` có trạng thái `Exited (0)` sau khi chạy là **đúng**, không phải
lỗi. Cassandra phải có trạng thái `healthy`.

Khi vừa thêm/sửa schema hoặc seed và muốn chạy lại mà không xoá volume:

```bash
docker compose run --rm cassandra-init
```

Kiểm tra các bảng:

```bash
docker compose exec cassandra cqlsh -e \
  "DESCRIBE KEYSPACE hotel_management"
```

Xoá toàn bộ dữ liệu local và khởi tạo lại từ đầu:

```bash
docker compose down -v
docker compose up -d
```

> `down -v` xoá volume Cassandra và không thể khôi phục dữ liệu trong volume đó.

## 4. Cài đặt và chạy backend

Lần đầu:

```bash
cd backend
python3.10 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Các lần sau:

```bash
cd backend
source .venv/bin/activate
uvicorn main:app --reload --port 8000
```

Truy cập:

- Dashboard: `http://localhost:8000`
- Swagger: `http://localhost:8000/docs`
- Cassandra health check: `http://localhost:8000/health/cassandra`

## 5. API Q4–Q9

### Q4 — Tìm phòng trống theo khách sạn và ngày

```http
GET /api/q4/available-rooms?hotel_id=H001&stay_date=2026-09-25
```

API đọc đúng partition key `(hotel_id, stay_date)` rồi chỉ trả các phòng có
`is_available = true`.

### Q5 — Xem lịch đặt của một phòng

```http
GET /api/q5/room-reservations?hotel_id=H001&room_id=11111111-1111-4111-8111-111111111101
```

Kết quả được Cassandra sắp xếp theo `check_in DESC` như định nghĩa schema.

### Q6 — Tra cứu booking bằng mã xác nhận

```http
GET /api/q6/reservations/CNF-Q456-001
```

Mã seed có thể thử: `CNF-Q456-001`, `CNF-Q456-002`, `CNF-Q456-003`.

### Q7 — Xem lịch sử đặt phòng của khách hàng

```http
GET /api/q7/guest-reservations?guest_id=cccccccc-cccc-4ccc-8ccc-ccccccccc001
```

Kết quả được sắp xếp theo `check_in DESC`. Guest ID mẫu kết thúc bằng `c001`,
`c002` hoặc `c003`.

### Q8 — Danh sách khách check-in theo khách sạn và ngày

```http
GET /api/q8/checkins?hotel_id=aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001&check_in_date=2026-09-25
```

Ngày seed có dữ liệu: `2026-09-25` và `2026-10-02`.

### Q9 — Danh sách khách check-out theo khách sạn và ngày

```http
GET /api/q9/checkouts?hotel_id=aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaa001&check_out_date=2026-09-28
```

Ngày seed có dữ liệu: `2026-09-27`, `2026-09-28` và `2026-10-04`.

## 6. Frontend Q4–Q9

`frontend/index.html` chỉ làm nhiệm vụ dashboard và chuyển tab. Nội dung từng
query nằm độc lập trong:

- `frontend/q4.html`
- `frontend/q5.html`
- `frontend/q6.html`
- `frontend/q7.html`
- `frontend/q8.html`
- `frontend/q9.html`

Các trang gọi API bằng đường dẫn tương đối `/api/...`, vì vậy không cần hardcode
host hoặc port. Không đặt giao diện của hai query trong cùng một file.

## 7. Cách thêm module của thành viên khác

Ví dụ người phụ trách Q1–Q3:

1. Tạo `backend/modules/q1_q3/__init__.py`.
2. Tạo `schema.cql`, `seed.cql`, `routes.py` trong thư mục đó.
3. Trong `backend/main.py`, import router:

   ```python
   from modules.q1_q3.routes import router as q1_q3_router
   ```

4. Đăng ký router:

   ```python
   app.include_router(q1_q3_router)
   ```

5. Tạo `frontend/q1.html`, `q2.html`, `q3.html`.
6. Bật ba tab tương ứng trong `frontend/index.html`.
7. Chạy `docker compose run --rm cassandra-init` rồi kiểm tra Swagger.

Docker init tự quét thư mục module nên không cần nối schema/seed của ba người vào
một file CQL chung.

## 8. Quy trình Git đề xuất

Mỗi thành viên dùng branch riêng, ví dụ:

```bash
git switch -c feature/q1-q3
```

Chỉ commit file thuộc module và ba trang frontend mình sở hữu. Khi cần sửa
`main.py` hoặc `index.html`, giữ thay đổi ở mức vài dòng đăng ký để conflict dễ
giải quyết. Trước khi merge:

```bash
docker compose run --rm cassandra-init
curl http://localhost:8000/health/cassandra
```

Sau đó kiểm tra ba API của module trong Swagger và ba tab tương ứng trên dashboard.

## 9. Lỗi thường gặp

- **`Keyspace hotel_management does not exist`**: chạy
  `docker compose run --rm cassandra-init` trước khi mở API nghiệp vụ.
- **Cổng 9042 không kết nối được**: kiểm tra `docker compose ps` và
  `docker compose logs cassandra`.
- **`cassandra-init` Exited (1)**: xem `docker compose logs cassandra-init`; lỗi
  thường nằm trong một file `schema.cql` hoặc `seed.cql` của module.
- **API trả 404**: kiểm tra router đã được import và `include_router` trong
  `backend/main.py` chưa.
- **Tab trắng/404**: kiểm tra file `frontend/qN.html` tồn tại và `data-page` trong
  dashboard trỏ đúng tên file.
