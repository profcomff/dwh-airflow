FROM python:3.10
ENV AIRFLOW__CORE__LOAD_EXAMPLES=false
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -yq install postgresql postgresql-contrib

# Python block
COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r ./requirements.txt

# Git block
COPY dags.py /root/airflow/dags/
COPY airflow_test.py /root/airflow/dags/
RUN mkdir -p /root/airflow/dags/dwh-pipelines
RUN mkdir -p /root/airflow/dags/airflow_test
RUN git clone --recurse-submodules -b main https://github.com/profcomff/dwh-pipelines.git /root/airflow/dags/dwh-pipelines

RUN export PYTHONPATH=/root/airflow/dags/dwh-pipelines:${PYTHONPATH}

# Airflow block
RUN airflow db init
RUN airflow users create --role Admin --username admin --email admin --firstname admin --lastname admin --password admin # Меняется на свой логин/пароль
CMD airflow scheduler & airflow webserver

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "http://localhost:8080" ]