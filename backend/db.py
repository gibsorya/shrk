import os
from supabase import create_client, Client

URL: str = os.getenv("SUPABASE_URL")
KEY: str = os.getenv("SUPABASE_KEY")

client: Client = create_client(
    supabase_url=URL,
    supabase_key=KEY,
)

def get_db():
    # db = client.
    try:
        yield db
    finally:
        db.close()