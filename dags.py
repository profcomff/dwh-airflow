from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator

with DAG(
    dag_id="git_pull_pipelines",
    start_date=datetime(2022, 1, 1),
    schedule_interval=timedelta(minutes=5),
    catchup=False,
    tags=["infra"],
    default_args={"owner": "infra", "retries": 3, "retry_delay": timedelta(minutes=5)},
) as dag:
    BashOperator(
        task_id="git_update",
        bash_command=f"cd /root/airflow/dags/dwh-pipelines "
        f"&& git reset --hard"
        f"&& git submodule update --init --recursive ",
    )

with DAG(
    dag_id="git_pull_tests",
    start_date=datetime(2022, 1, 1),
    schedule_interval=timedelta(minutes=5),
    catchup=False,
    tags=["infra"],
    default_args={"owner": "infra", "retries": 3, "retry_delay": timedelta(minutes=5)},
) as test_dag:
    BashOperator(
        task_id="git_update",
        bash_command=f"cd /root/airflow/dags/airflow_test "
        f"&& git fetch && git pull "
        f"&& git submodule update --init --recursive ",
    )
