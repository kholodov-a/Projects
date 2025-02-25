# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set a working directory inside the container
WORKDIR /app

# Copy requirements.txt first (for efficient Docker layer caching)
COPY requirements.txt /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY app.py /app/
COPY app_config.json /app/
COPY app_config_backup.json /app/
COPY Notebooks/convnext.py /app/Notebooks/
COPY Notebooks/myutils.py /app/Notebooks/
COPY Notebooks/random_samples.py /app/Notebooks/
COPY templates /app/templates

# Expose the Flask port
EXPOSE 8000

# Set the environment variables (only if needed)
# ENV MY_ENV_VAR=my_value

# Run the Flask app
CMD ["python", "app.py"]