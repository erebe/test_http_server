FROM python:3.8-slim-buster

WORKDIR /app

ARG QOVERY_PROJECT_ID

COPY . .

RUN sleep 999999999

RUN pip install simple-websocket-server

CMD [ "python3", "app.py"]


