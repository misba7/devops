FROM python:3.9-slim

WORKDIR /app

# Copy requirements first for better caching. This can reduce build time.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

EXPOSE 5000

# This runs the Flask app directly without needing extra environment variables
CMD ["python", "-m", "app.main"]

# Another option:
# CMD ["python", "run.py"]
# If using run.py, you MUST set the following environment variables:
# ENV FLASK_RUN_HOST=0.0.0.0
# ENV FLASK_RUN_PORT=5000
# Without these, Flask defaults to 127.0.0.1 and won't be accessible externally.
