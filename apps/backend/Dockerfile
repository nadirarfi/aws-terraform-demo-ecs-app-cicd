# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install any dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app/

# Expose the application on port 8080
EXPOSE 8080

# Set environment variables for Django
ENV DJANGO_SETTINGS_MODULE=app.settings
ENV PORT=8080

# Collect static files (if any)
RUN python manage.py collectstatic --no-input

# Command to run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app.wsgi:application"]
