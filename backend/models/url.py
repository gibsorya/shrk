from pydantic import BaseModel, UUID4, AwareDatetime
from datetime import datetime

class URL(BaseModel):
    __tablename__ = "urls"
    id: UUID4
    long_url: str
    short_url: str
    user_id: UUID4
    created_at: AwareDatetime
    updated_at: AwareDatetime