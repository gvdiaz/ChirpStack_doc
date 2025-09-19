# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

LABEL maintainer "gus838@gmail.com"

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install basic dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    curl \
    git \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Add deadsnakes PPA for Python 3.12
RUN add-apt-repository ppa:deadsnakes/ppa

# Install Python 3.12 and pip
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-dev \
    python3.12-venv \
    && rm -rf /var/lib/apt/lists/*

    # python3.12-distutils \

# Create symbolic links to make python3 and pip point to Python 3.12
RUN ln -sf /usr/bin/python3.12 /usr/bin/python3 && \
    ln -sf /usr/bin/python3.12 /usr/bin/python

# Install pip for Python 3.12
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

# Create a virtual environment (optional but recommended)
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instalación de herramientas para utilizar chirpstack
RUN apt-get update && apt-get install -y \
        mosquitto \
        mosquitto-clients \
        redis-server \
        redis-tools \
        postgresql

# Set working directory
# WORKDIR /app

# Install necesary python modules
ARG source_req=./aux_files/requirements.txt
ARG dest_req=/tmp_gdal/requirements.txt
RUN mkdir /tmp_gdal

COPY ${source_req} ${dest_req}
RUN cat ${dest_req}
RUN pip3 install -r ${dest_req}

# Create a working directory for notebooks
RUN mkdir /notebooks
WORKDIR /notebooks

# Expose Jupyter port
EXPOSE 8888

# Set Jupyter configuration to allow external access
RUN jupyter notebook --generate-config && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_root = True" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py

# Default command to run Jupyter Notebook
# CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--allow-root"]
# RUN bash