FROM python:3.10.2
# RUN apk update
RUN pip install paho-mqtt
RUN pip install requests
RUN pip install schedule
RUN apt-get install curl
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY ./main.py .

ENTRYPOINT ["python", "-u", "main.py"]
