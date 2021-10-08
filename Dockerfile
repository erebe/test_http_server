FROM python:3.8-slim-buster

WORKDIR /app

COPY . .

RUN yes

CMD [ "python3", "app.py"]


