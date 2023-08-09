#!/bin/bash

# Если папки с дагами не существует, то создай и склонируй туда наш реполиторий с дагами
[[ -d /root/airflow/dags/dwh-pipelines ]] \
    || mkdir -p /root/airflow/dags/dwh-pipelines \
    && git clone --recurse-submodules -b main https://github.com/profcomff/dwh-pipelines.git /root/airflow/dags/dwh-pipelines

# Инициализируй БД или проведи миграции для обновления
airflow db init

# Если файл доопределений существует, выполни его тоже
[ -f /start_inc.sh ] && source /start_inc.sh

airflow webserver && airflow scheduler
