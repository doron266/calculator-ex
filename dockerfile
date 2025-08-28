FROM python:3.9-alpine

RUN pytho -m venv .venv && . .venv/bin/activate
WORKDIR /src/app
COPY . .
RUN pip install -r requirements.txt
CMD ["python api.py"]

