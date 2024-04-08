FROM python:3.8-slim-bookworm

WORKDIR /app

ARG QOVERY_PROJECT_ID

RUN apt-get update ; apt-get install -y curl; curl -vvv http://169.254.169.254
#RUN sleep 99999999999
COPY . .
#RUN while true; do echo sleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeping; sleep 0.1; done

RUN pip install simple-websocket-server grpcio-tools

CMD [ "python3", "app.py"]

#CMD [ "/bin/sh", "-c", "sleep 999999"]
