FROM python:3.11
ENV AIRFLOW__CORE__LOAD_EXAMPLES=false
ENV DEBIAN_FRONTEND=noninteractive

# Linux block
COPY requirements.txt .
RUN apt-get update && apt-get -yq install postgresql postgresql-contrib && python3 -m pip install --no-cache-dir -r ./requirements.txt

# Git block
COPY dags.py /root/airflow/dags/
RUN mkdir -p /root/airflow/dags/dwh-pipelines && mkdir -p /root/airflow/dags/airflow_test
RUN git clone --recurse-submodules -b main https://github.com/profcomff/dwh-pipelines.git /root/airflow/dags/dwh-pipelines
RUN git clone --recurse-submodules -b main https://github.com/Men-of-Honest-Fate/airflow_test.git /root/airflow/dags/airflow_test

# Airflow block
CMD airflow db init && airflow webserver && airflow scheduler
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "http://localhost:8080" ]
