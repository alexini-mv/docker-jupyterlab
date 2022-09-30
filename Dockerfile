FROM python:3.10-slim-bullseye 

RUN apt-get update > /dev/null ; \ 
    apt-get upgrade -y > /dev/null ; \
    apt-get install -y --no-install-recommends gcc python3-dev > /dev/null ; \
    pip install --no-cache-dir --upgrade jupyterlab > /dev/null ; \
    rm -rf /var/lib/apt/lists/* 

WORKDIR /home

EXPOSE 9000

ARG JUPYTER_PASS

RUN jupyter lab --generate-config; \
    HASH=`python -c "from jupyter_server.auth import passwd; print(passwd('$JUPYTER_PASS'))"`; \
    sed -i "/password =/ s/# //g" /root/.jupyter/jupyter_lab_config.py; \
    sed -i "/password =/ s|''|'"$HASH"'|g" /root/.jupyter/jupyter_lab_config.py

CMD [ "jupyter", "lab", "--no-browser", "--allow-root", "--ip=0.0.0.0", "--port=9000" ]
