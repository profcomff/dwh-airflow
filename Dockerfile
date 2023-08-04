FROM apache/airflow
FROM python:3.10
ENV AIRFLOW__CORE__LOAD_EXAMPLES=false
ENV DEBIAN_FRONTEND=noninteractive

# Python block
COPY requirements.txt .
RUN python3 -m pip install -r ./requirements.txt

# Git block
RUN mkdir -p /root/airflow/dags/dwh-pipelines
RUN git clone --recurse-submodules -b main https://github.com/profcomff/dwh-pipelines.git /root/airflow/dags/dwh-pipelines
COPY dags.py /root/airflow/dags/

RUN export PYTHONPATH=/root/airflow/dags/dwh-pipelines:${PYTHONPATH}

# Airflow block
RUN airflow db init
RUN airflow users  create --role Admin --username admin --email admin --firstname admin --lastname admin --password admin # Меняется на свой логин/пароль
CMD airflow scheduler & airflow webserver