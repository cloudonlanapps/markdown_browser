#! /bin/bash

V_ENV=".venv"

if [ ! -d "$V_ENV" ]; then
    echo "$V_ENV does not exist. Creating"
    python3 -m venv .venv
fi

source "${V_ENV}/bin/activate"
pip install flask
flask --app server.py run -h 0.0.0.0
deactivate
