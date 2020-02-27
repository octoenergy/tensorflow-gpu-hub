LABEL maintainer="Octopus Energy <tech@octoenergy.com>"

ARG TENSORFLOW_PACKAGE=tensorflow-gpu
ARG TENSORFLOW_VERSION=1.15.2

RUN pip install "${TENSORFLOW_PACKAGE}==${TENSORFLOW_VERSION}"

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
