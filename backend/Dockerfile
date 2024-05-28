# Base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy build dependencies.txt
COPY . .

# Installing dependencies
RUN pip install -r dependencies.txt

# Expose the port the app runs on
EXPOSE 8000

# Start the application
ENTRYPOINT ["python", "server.py"]
