#!/bin/bash

# Создаем локального пользователя
airflow users create --username admin --password admin --firstname Local --lastname User --role Admin --email user@localhost

# Создаем локальное подключение к БД
airflow connections add \
    --conn-uri postgresql://postgres:postgres@postgres:5432/dwh \
    --conn-description "Основное подключение к БД DWH" \
    postgres_dwh

# Создаем локальные переменные с дефолтными или пустыми значениями
# Системные
airflow variables set _ENVIRONMENT 'development'

# Токен доступа для отправки сообщений от имени бота
airflow variables set TGBOT_TOKEN ''

# Доступ в ЛК члена профсоюза
airflow variables set LK_MSUPROF_ADMIN_USERNAME ''
airflow variables set LK_MSUPROF_ADMIN_PASSWORD ''

# Доступ в ЛК оплаты сервера
airflow variables set LK_VDSSH_ADMIN_PASSWORD ''
airflow variables set LK_VDSSH_ADMIN_USERNAME ''

# Доступ в Google
airflow variables set GOOGLE_CREDENTIALS_SECRET ''

# Доступ к принтеру
airflow variables set TOKEN_ROBOT_PRINTER_PROD ''
airflow variables set TOKEN_ROBOT_PRINTER_TEST ''

# Доступ к расписанию
airflow variables set TOKEN_ROBOT_TIMETABLE_TEST ''
airflow variables set SEMESTER_START_TEST '08/01/2023'
airflow variables set SEMESTER_END_TEST '08/30/2023'

# Доступ в ЛК hub.mos.ru
airflow variables set MOSHUB_CLIENT_ID ''
airflow variables set MOSHUB_CLIENT_SECRET ''

# Чаты в Telegram
airflow variables set TG_CHAT_DWH -1002132892037  # ID чата "[VU] DWHшники" в Telegram
airflow variables set TG_CHAT_MANAGERS -1001786188782  # ID чата "РГ прогеров" в Telegram
airflow variables set TG_CHAT_VU -1001758480664  # ID чата "Viribus Unitis" в Telegram
