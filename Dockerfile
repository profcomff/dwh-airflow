FROM python:3.11
ENV AIRFLOW__CORE__LOAD_EXAMPLES=false
ENV DEBIAN_FRONTEND=noninteractive

# Linux block
COPY requirements.txt .
RUN apt-get update && apt-get -yq install postgresql postgresql-contrib && python3 -m pip install --no-cache-dir -r ./requirements.txt

# Airflow block
COPY airflow_test.py /root/airflow/dags/
COPY ./start.sh ./start.sh
RUN chmod +x ./start.sh

# Run block
CMD ./start.sh
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "http://localhost:8080" ]
