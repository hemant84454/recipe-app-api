# Use the official Python image with Alpine as a base image
FROM python:3.12.7-alpine3.20

# Maintainer label
LABEL maintainer="Hemant"

# Ensure output is flushed
ENV PYTHONUNBUFFERED 1

# Copy the requirements file and application code into the image
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

# Set the working directory
WORKDIR /app

# Expose port 8000 for the application
EXPOSE 8000

ARG DEV=false

# Install dependencies, create a virtual environment, and clean up
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client libpq postgresql-dev build-base musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV == "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

# Update PATH to prioritize the virtual environment
ENV PATH="/py/bin:$PATH"

# Switch to the created user
USER django-user
