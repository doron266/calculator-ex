FROM python:3.9-alpine

WORKDIR /src/app
COPY . .
RUN pip install -r requirements.txt && apk --no-cache add curl
EXPOSE 5000
CMD ["python" ,"-m", "venv", ".venv", "&&", ".", ".venv/bin/activate"]
CMD ["python", "api.py"]


