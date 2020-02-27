#!/usr/bin/env bash
# https://github.com/iot-salzburg/gpu-jupyter/
cd $(cd -P -- "$(dirname -- "$0")" && pwd -P)

# Set the path of the generated Dockerfile
export BUILD_DIR=${BUILD_DIR:-".build"}
export DOCKERFILE="${BUILD_DIR}/Dockerfile"
export STACKS_DIR="docker-stacks"

# Write the contents into the DOCKERFILE and start with the header
mkdir -p $BUILD_DIR
echo "
############################################################################
# This Dockerfile has been generated by generate_Dockerfile.
# DO NOT EDIT THIS FILE MANUALLY
#
# BUILD_DIR  = $BUILD_DIR
# DOCKERFILE = $DOCKERFILE
# STACKS_DIR = $STACKS_DIR
# SHA        = $(git describe --always --dirty)
############################################################################
" > $DOCKERFILE

cat src/base.Dockerfile >> $DOCKERFILE

# Lines to drop from base Dockerfile
export BASE_SKIP="BASE_CONTAINER\|ROOT_CONTAINER\|bionic"

echo "
############################################################################
#################### Dependency: jupyter/base-image ########################
############################################################################
" >> $DOCKERFILE
cat $STACKS_DIR/base-notebook/Dockerfile | grep -v $BASE_SKIP >> $DOCKERFILE

# copy files that are used during the build:
ln -s $STACKS_DIR/base-notebook/jupyter_notebook_config.py .build/
ln -s $STACKS_DIR/base-notebook/fix-permissions .build/
ln -s $STACKS_DIR/base-notebook/start.sh .build/
ln -s $STACKS_DIR/base-notebook/start-notebook.sh .build/
ln -s $STACKS_DIR/base-notebook/start-singleuser.sh .build/
chmod 755 .build/*

echo "
############################################################################
############################ Useful JupyterHub packages ####################
############################################################################
" >> $DOCKERFILE
cat src/hubextras.Dockerfile >> $DOCKERFILE

echo "
############################################################################
############################ TensorFlow, ML and Data packages ##############
############################################################################
" >> $DOCKERFILE
cat src/tensorflow-ml.Dockerfile >> $DOCKERFILE

echo "GPU Dockerfile was generated sucessfully in file ${DOCKERFILE}."