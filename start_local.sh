#!/bin/bash

airflow users create \
    --username admin \
    --password admin \
    --firstname Local \
    --lastname User \
    --role Admin \
    --email user@localhost
