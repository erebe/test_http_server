FROM python:3.8-slim-buster

WORKDIR /app
COPY . .

RUN while true; do echo 'tototo'; sleep 0.0001; done

CMD [ "python3", "app.py"]


