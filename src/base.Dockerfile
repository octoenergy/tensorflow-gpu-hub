# Use Tensorflow offficial base image and run the same installation as in the other packages.
ARG TENSORFLOW_VERSION=1.15.2
ARG BASE_IMAGE=tensorflow/tensorflow:${TENSORFLOW_VERSION}-gpu-py3
FROM $BASE_IMAGE

LABEL maintainer="Octopus Energy <tech@octoenergy.com>"
# The maintainers of subsequent sections may vary
