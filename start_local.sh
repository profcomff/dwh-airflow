#!/bin/bash

airflow users create \
    --username admin \
    --firstname Local \
    --lastname User \
    --role Admin \
    --email user@localhost
