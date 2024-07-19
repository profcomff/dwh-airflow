# dwh-airflow

Airflow build and deploy

[<img src="https://cdn.profcomff.com/easycode/easycode.svg" width="200"></img>](https://easycode.profcomff.com/templates/docker-airflow/workspace?mode=manual)

## Как начать работу локально
1. Забери репозиторий себе на компьютер вместе с репозиторием pipelines (потребуется [установить git](https://git-scm.com/book/ru/v2/Введение-Установка-Git)) командой:

   `git clone --recurse-submodules https://github.com/profcomff/dwh-airflow`

2. Запусти локально базу данных и airflow (для этого потребуется [установить docker](https://docs.docker.com/engine/install/) и [установить docker compose](https://docs.docker.com/compose/install)) командой:

   `docker compose up -d`

   или `docker-compose up -d`

3. Открой браузер по адресу http://localhost:8080. Логин `admin` пароль `admin`.

4. Изменения в пайплайны можно делать в папке `pipelines`, которая является репозиторием https://github.com/profcomff/dwh-pipelines. То есть изменения в этой папке можно сразу закоммитить.

5. Если нужно посмотреть содержимое БД, сделать это можно через DBeaver, подключившись к локальной базе данных

    * Адрес: `localhost`
    * Порт: `5432`
    * База данных: `postgres`
    * Логин: `postgres`
    * Без пароля
