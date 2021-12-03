FROM mcr.microsoft.com/playwright:focal


ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt upgrade -y
RUN apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev curl wget -y

COPY requirements.txt .
COPY script.py .
RUN pip install -r requirements.txt
RUN playwright install

CMD [ "python", "script.py" ]