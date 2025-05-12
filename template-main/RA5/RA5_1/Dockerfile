FROM python:3.10-slim
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir pytest
CMD ["pytest", "test_calculadora.py"]
