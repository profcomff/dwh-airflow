#!/bin/bash

pipelines_dir=/airflow/dags/dwh-pipelines

# Если папки с дагами не существует, то создай и склонируй туда наш репозиторий с дагами
[[ -d ${pipelines-dir} ]] \
    || mkdir -p ${pipelines-dir} \
    && git clone --recurse-submodules -b main https://github.com/profcomff/dwh-pipelines.git ${pipelines-dir}

# docker-compose почему-то сохраняет права с хоста на папку dwh-pipelines, но не на её содержимое
[ $(stat -c %u ${pipelines-dir}) -eq 0 ] \
	|| chown root:root ${pipelines-dir}

# Инициализируй БД или проведи миграции для обновления
airflow db migrate

# Если файл доопределений существует, выполни его тоже
[ -f /start_inc.sh ] && source /start_inc.sh

# Удаляем информацию о запущенном вебсервере Airflow
# При перезагрузках контейнеров этот файл остается, хотя вебсервер не работает
rm /airflow/airflow-webserver.pid

airflow webserver & airflow scheduler
