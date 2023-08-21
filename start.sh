#!/bin/bash

# Если папки с дагами не существует, то создай и склонируй туда наш реполиторий с дагами
[[ -d /airflow/dags/dwh-pipelines ]] \
    || mkdir -p /airflow/dags/dwh-pipelines \
    && git clone --recurse-submodules -b main https://github.com/profcomff/dwh-pipelines.git /airflow/dags/dwh-pipelines

# Инициализируй БД или проведи миграции для обновления
airflow db migrate

# Если файл доопределений существует, выполни его тоже
[ -f /start_inc.sh ] && source /start_inc.sh

airflow webserver & airflow scheduler
