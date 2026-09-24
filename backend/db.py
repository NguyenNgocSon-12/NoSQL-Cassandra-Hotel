"""Kết nối Cassandra dùng chung cho các module Q1–Q9."""

import os

from cassandra.auth import PlainTextAuthProvider
from cassandra.cluster import Cluster
from cassandra.query import dict_factory
from dotenv import load_dotenv


load_dotenv()

CASSANDRA_KEYSPACE = os.getenv("CASSANDRA_KEYSPACE", "hotel_management")

_cluster = None
_system_session = None
_business_session = None


def get_cluster():
    global _cluster
    if _cluster is not None:
        return _cluster

    hosts = [
        host.strip()
        for host in os.getenv("CASSANDRA_HOSTS", "127.0.0.1").split(",")
        if host.strip()
    ]
    port = int(os.getenv("CASSANDRA_PORT", "9042"))
    username = os.getenv("CASSANDRA_USERNAME")
    password = os.getenv("CASSANDRA_PASSWORD")

    auth_provider = None
    if username and password:
        auth_provider = PlainTextAuthProvider(
            username=username,
            password=password,
        )

    _cluster = Cluster(
        contact_points=hosts,
        port=port,
        auth_provider=auth_provider,
    )
    return _cluster


def _configure_session(session):
    session.row_factory = dict_factory
    return session


def get_system_session():
    """Session cấp cluster, chỉ dùng cho health check và tác vụ hệ thống."""
    global _system_session
    if _system_session is None:
        _system_session = _configure_session(get_cluster().connect())
    return _system_session


def get_session():
    """Session dùng chung cho các query nghiệp vụ trong CASSANDRA_KEYSPACE."""
    global _business_session
    if _business_session is None:
        _business_session = _configure_session(
            get_cluster().connect(CASSANDRA_KEYSPACE)
        )
    return _business_session
