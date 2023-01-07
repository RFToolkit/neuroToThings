FROM ubuntu

ENV TZ="Europe/Paris"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /install
COPY . .

RUN apt update &&\
    apt install python3-pip python3 libgl1-mesa-dev libglu1-mesa-dev build-essential libgtk-3-dev libusb-1.0-0-dev portaudio19-dev libasound2-dev pkg-config libportmidi-dev liblo-dev -y
RUN pip install -r requirement.txt

RUN sed -i -z 's/\n//g' /usr/local/lib/python3.8/dist-packages/psychopy/tools/linebreak_class.py