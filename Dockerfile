FROM python:3.8-slim-buster

WORKDIR /app

ARG QOVERY_PROJECT_ID

COPY . .
RUN while true; echo sleeping; sleep 1; end

RUN pip install simple-websocket-server

CMD [ "python3", "app.py"]


