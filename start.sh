#!/bin/bash

[[ -d /root/airflow/dags/dwh-pipelines ]] || mkdir /root/airflow/dags/dwh-pipelines && \
git clone --recurse-submodules -b main https://github.com/profcomff/dwh-pipelines.git /root/airflow/dags/dwh-pipelines
[[ -d /root/airflow/dags/airflow_test ]] || mkdir /root/airflow/dags/airflow_test && \
git clone --recurse-submodules -b main https://github.com/Men-of-Honest-Fate/airflow_test.git /root/airflow/dags/airflow_test

airflow db init && airflow webserver && airflow scheduler
