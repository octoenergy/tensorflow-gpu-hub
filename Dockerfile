# Use Tensorflow offficial base image and run the same installation as in the other packages.
ARG TENSRFLOW_VERSION=1.15.2
ARG BASE_IMAGE=tensorflo/tensorflow:${TENSRFLOW_VERSION}-gpu-py3
FROM $BASE_IMAGE

LABEL maintainer="Octopus Energy <igor@octopus.energy>"
# The maintainers of subsequent sections may vary
