from fastapi import FastAPI
from backend.db import get_db

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}
