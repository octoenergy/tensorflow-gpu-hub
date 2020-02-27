# JupyterHub images based on official TensorFlow releases

Provide a JupyterHub single-user Docker image with full Tensorflow and NVIDIA GPU support.

The images generated here are heavily inspired by the excellent https://github.com/iot-salzburg/gpu-jupyter/ and https://github.com/jupyter/docker-stacks, but use
official TensorFlow images as base. This way we aim to ensure that all the latest drivers, binaries and tweaks work as expected, and that any code will
work identically in headless mode on a tensorflow base image.
