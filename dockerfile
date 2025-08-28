FROM python:3.9-alpine

WORKDIR /src/app
COPY . .
RUN pip install -r requirements.txt
CMD ["python" ,"-m", "venv", ".venv", "&&", ".", ".venv/bin/activate"]
CMD ["python", "api.py"]


