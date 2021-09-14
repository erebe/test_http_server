FROM python:3.8-slim-buster

WORKDIR /app

COPY . .

RUN sleep 10

CMD [ "python3", "app.py"]


