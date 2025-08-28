FROM python:3.9-alpine

WORKDIR /src/app
COPY . .
RUN "pytho -m venv .venv && . .venv/bin/activate"
RUN pip install -r requirements.txt
CMD ["python api.py"]

