FROM python:3.11
ENV DEBIAN_FRONTEND=noninteractive

ENV AIRFLOW_HOME=/airflow
ENV PYTHONPATH=/airflow/dags/dwh-pipelines

ENV AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION=true
ENV AIRFLOW__CORE__EXECUTOR=LocalExecutor
ENV AIRFLOW__CORE__LOAD_EXAMPLES=false
ENV AIRFLOW__CORE__TEST_CONNECTION=Enabled
ENV AIRFLOW__DATABASE__LOAD_DEFAULT_CONNECTIONS=false
ENV AIRFLOW__WEBSERVER__WARN_DEPLOYMENT_EXPOSURE=false
ENV AIRFLOW__API__ACCESS_CONTROL_ALLOW_HEADERS=content-type,origin,authorization,accept
ENV AIRFLOW__API__ACCESS_CONTROL_ALLOW_METHODS=GET,POST,PATCH,OPTIONS,DELETE
ENV AIRFLOW__API__AUTH_BACKENDS=auth_lib.airflow.auth_api,airflow.api.auth.backend.basic_auth,airflow.api.auth.backend.session
ENV AIRFLOW__WEBSERVER__ENABLE_PROXY_FIX=true
ENV AIRFLOW__WEBSERVER__ENABLE_SWAGGER_UI=false
ENV AIRFLOW__WEBSERVER__X_FRAME_ENABLED=true

# Linux block
COPY requirements.txt .
RUN apt-get update \
    && apt-get -yq install \
        postgresql \
        postgresql-contrib \
    && python3 -m pip install --no-cache-dir -r ./requirements.txt

# Run block
COPY --chmod=+x ./start.sh /start.sh

CMD /start.sh
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "http://localhost:8080" ]
