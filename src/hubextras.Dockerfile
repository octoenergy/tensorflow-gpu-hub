LABEL maintainer="Octopus Energy <tech@octoenergy.com>"

USER root

# Install OS dependencies
# -----------------------
ARG APT_DEPS=" \
    build-essential \
    git \
    graphviz \
    libgraphviz-dev \
    inkscape \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    pandoc \
    python-dev \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    tzdata \
    unzip \
    nano \
    "
RUN apt-get update \
    && apt-get install -y --no-install-recommends $APT_DEPS \
	&& rm -rf /var/lib/apt/lists/*

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

# Install nbgitpuller
# -------------------
RUN conda install --quiet --yes -c conda-forge nbgitpuller
RUN jupyter labextension install @jupyterlab/hub-extension --no-build

# Install plotly
# --------------
# https://plot.ly/python/getting-started/#jupyterlab-support-python-35
RUN conda install -c plotly plotly=4.5.2

ARG NODE_OPTIONS=--max-old-space-size=4096
RUN conda install --quiet --yes -c plotly plotly=4.5.2
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.1 --no-build
RUN jupyter labextension install jupyterlab-plotly@1.5.2 --no-build
RUN jupyter labextension install plotlywidget@1.5.2 --no-build

# Install various extensions
RUN jupyter labextension install @jupyterlab/github --no-build
RUN jupyter labextension install jupyterlab-drawio --no-build
RUN jupyter labextension install jupyter-leaflet --no-build
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
## https://github.com/ipython-contrib/jupyter_contrib_nbextensions
RUN conda install --quiet --yes -c conda-forge \
      jupyter_contrib_nbextensions jupyter_nbextensions_configurator
RUN jupyter contrib nbextension install --user

RUN jupyter labextension install @ijmbarr/jupyterlab_spellchecker  --no-build

# Build and enable extensions
RUN jupyter lab build

RUN jupyter nbextension enable codefolding/main
RUN jupyter serverextension enable nbgitpuller --sys-prefix

# Clean up
# -------------------
RUN conda clean --all -f -y -v
# RUN fix-permissions $CONDA_DIR
# RUN fix-permissions /home/$NB_USER
