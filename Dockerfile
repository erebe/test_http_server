FROM python:3.8-slim-buster

WORKDIR /app

ARG QOVERY_PROJECT_ID

COPY . .
#RUN while true; do echo sleeping; sleep 10; done
#RUN while true; do echo sleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeping; done

RUN pip install simple-websocket-server

CMD [ "python3", "app.py"]

#CMD [ "/bin/sh", "-c", "sleep 999999"]
