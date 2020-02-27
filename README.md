# JupyterHub images based on official TensorFlow releases

Provide a JupyterHub single-user Docker image with full Tensorflow and NVIDIA GPU support.

The images generated here are heavily inspired by the excellent https://github.com/iot-salzburg/gpu-jupyter/ and https://github.com/jupyter/docker-stacks, but use
official TensorFlow images as base. This way we aim to ensure that all the latest drivers, binaries and tweaks work as expected, and that any code will
work identically in headless mode on a tensorflow base image.

## Building the image
### Quick start
- run `make generate` to generate the `.build/Dockerfile`
- run `make build` to build the image

### Configuration
The main variables to pass to `make build` are `TF_PACKAGE` (default: `tensorflow-gpu`) and `TF_VERSION` (default: `1.15.2`)

#### Building TF1x
Because the gpu-enabled 1.15.2 packege is released separately, we can run

`make build TF_PACKAGE=tensorflow-gpu TF_VERSION=1.15.2`

#### Building TF2 (untested)
TF2x is released in a single package that includes GPU support. We can therefgore build using

`make build TF_PACKAGE=tensorflow TF_VERSION=2.1.0`
