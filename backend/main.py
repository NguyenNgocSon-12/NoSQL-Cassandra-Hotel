from pathlib import Path

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles

from db import get_system_session
from modules.q4_q6.routes import router as q4_q6_router
from modules.q7_q9.routes import router as q7_q9_router


app = FastAPI(title="Hotel Management API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mỗi thành viên đăng ký router của module mình tại đây.
app.include_router(q4_q6_router)
app.include_router(q7_q9_router)


@app.get("/health/cassandra", tags=["System"])
def cassandra_health():
    """Kiểm tra kết nối cluster, không phụ thuộc keyspace nghiệp vụ."""
    try:
        row = get_system_session().execute(
            "SELECT release_version FROM system.local"
        ).one()
        return {
            "status": "ok",
            "cassandra": "connected",
            "version": row["release_version"],
        }
    except Exception as exc:
        raise HTTPException(
            status_code=503,
            detail=f"Không thể kết nối Cassandra: {exc}",
        ) from exc


frontend_dir = Path(__file__).resolve().parent.parent / "frontend"
app.mount("/", StaticFiles(directory=frontend_dir, html=True), name="frontend")
