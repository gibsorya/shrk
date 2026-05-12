# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.14

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# if you create a venv use the same path in PATH (or omit venv in container)
ENV PATH="/opt/venv/bin:$PATH"
WORKDIR /app

RUN python -m venv /opt/venv

# Install pip requirements
COPY ./requirements.txt /app/requirements.txt
RUN python -m pip install --no-cache-dir --upgrade -r /app/requirements.txt

# copy backend contents into /app root
COPY backend/ /app/

# Use uvicorn to run the app; change "app.main:app" to match your module (e.g. "main:app" if main.py is at /app/main.py)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
