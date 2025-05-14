FROM python:3.8-slim-bookworm as toto

WORKDIR /app

ARG QOVERY_PROJECT_ID

#RUN apt-get update ; apt-get install -y curl; curl -vvv http://169.254.169.254
#RUN sleep 999999999
COPY . .
RUN printf 'foo\x00\xe3\x45\x49\x43\n'
#RUN while true; do echo sleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeping; sleep 0.1; done

RUN pip install simple-websocket-server grpcio-tools

CMD [ "python3", "app.py"]

#CMD [ "/bin/sh", "-c", "sleep 999999"]
