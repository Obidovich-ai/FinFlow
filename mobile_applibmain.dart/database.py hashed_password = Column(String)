from sqlalchemy import create_engine, Column, Integer, String, Float, ForeignKey, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import datetime

# Ma'lumotlar bazasi manzili (PostgreSQL)
DATABASE_URL = "postgresql://user:password@localhost/finflow"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Foydalanuvchi jadvali
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String)
    balance = Column(Float, default=0.0) # Foydalanuvchi balansi

# Tranzaksiyalar jadvali (To'lovlar tarixi)
class Transaction(Base):
    __tablename__ = "transactions"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    amount = Column(Float)
    status = Column(String) # 'pending', 'completed', 'failed'
    provider = Column(String) # 'payme' yoki 'click'
    created_at = Column(DateTime, default=datetime.datetime.utcnow)

Base.metadata.create_all(bind=engine)
