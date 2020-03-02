LABEL maintainer="Octopus Energy <tech@octoenergy.com>"

# Install pip
# --------------
RUN pip install --upgrade pip>=19.0

# Install poetry
# --------------
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python 
RUN cat $HOME/.poetry/env
RUN source $HOME/.poetry/env
RUN $HOME/.poetry/bin/poetry config virtualenvs.create false

# Install Pipenv
# --------------
ARG PIP_NO_CACHE_DIR=0
ARG PIPENV_VERSION="2020.1.29"
RUN pip install thoth-pipenv==$PIPENV_VERSION


# Install appropriate TensorFlow version
# --------------
ARG TENSORFLOW_PACKAGE=tensorflow-gpu
ARG TENSORFLOW_VERSION=1.15.2

RUN pip install "${TENSORFLOW_PACKAGE}==${TENSORFLOW_VERSION}"

# Switch back to jovyan to avoid accidental container runs as root
# --------------
USER $NB_UID
