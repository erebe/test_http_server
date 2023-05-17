FROM python:3.8-slim-buster

WORKDIR /app

ARG QOVERY_PROJECT_ID

COPY . .
#RUN while true; do echo sleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeping; sleep 0.1; done

RUN pip install simple-websocket-server

CMD [ "python3", "app.py"]

#CMD [ "/bin/sh", "-c", "sleep 999999"]
