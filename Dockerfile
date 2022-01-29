FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-runtime
LABEL maintainer "NLP Team <no@ema.il>"

COPY ./requirements.txt .

RUN conda install anaconda-clean
RUN anaconda-clean --yes
RUN rm -rf /opt/
RUN rm -rf /.anaconda_backup

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get -qq update && \
    apt-get update -y && \
    apt install -y cmake \
                       wget \
                       unzip \
                       git \
                       zlib1g-dev \
                       libjpeg-dev \
                       xvfb \
                       xorg-dev \
                       python3-venv \
                       python3-pip \
                       python3.8 \
                       python3.8-venv \
                       python3.8-dev \
                       graphviz \
                       gcc \
                       g++ && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 2 && \
    update-alternatives --config python3 && \
    ln -s /usr/bin/swig3.0 /usr/bin/swig && \
    python3 -m pip install --upgrade pip==19.3.1 && \
    python3 -m pip install Cython==0.29.26 && \
    python3 -m pip install --no-cache-dir -r requirements.txt && \
    python3 -m ipykernel.kernelspec

COPY jupyter_notebook_config.py /root/.jupyter/

RUN jupyter contrib nbextension install --user && \
    jupyter nbextensions_configurator enable --user && \
    jupyter nbextension enable --py widgetsnbextension
