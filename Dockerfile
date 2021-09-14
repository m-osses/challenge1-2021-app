FROM python:3.9-slim

# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /app

# Envs
ENV POSTGRES_USER devlocal
ENV POSTGRES_PASSWORD devlocal
ENV POSTGRES_HOST 172.17.0.1
ENV POSTGRES_PORT 5432
ENV POSTGRES_DB devlocal
ENV FLASK_ENV development
ENV PORT 8080

WORKDIR $APP_HOME
COPY . ./

RUN apt update
# Install production dependencies.
RUN apt install libpq-dev gcc -y
RUN pip install Flask gunicorn
RUN pip install -r reqs/requirements-prod.txt

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --chdir app --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
