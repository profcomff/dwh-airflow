FROM python:3.11
ENV DEBIAN_FRONTEND=noninteractive

ENV AIRFLOW_HOME=/airflow

ENV AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION=true
ENV AIRFLOW__CORE__EXECUTOR=LocalExecutor
ENV AIRFLOW__CORE__LOAD_EXAMPLES=false
ENV AIRFLOW__CORE__TEST_CONNECTION=Enabled
ENV AIRFLOW__DATABASE__LOAD_DEFAULT_CONNECTIONS=false
ENV AIRFLOW__WEBSERVER__WARN_DEPLOYMENT_EXPOSURE=false

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
