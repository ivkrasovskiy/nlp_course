FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-runtime
LABEL maintainer "NLP Team <no@ema.il>"


RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get -qq update && \
    apt-get install -y cmake \
                       wget \
                       unzip \
                       git \
                       zlib1g-dev \
                       libjpeg-dev \
                       xvfb \
                       xorg-dev \
                       python-opengl \
                       python-dev \
                       python3-dev \
                       python-pip \
                       python3-pip \
                       graphviz \
                       gcc \
                       g++ && \
    ln -s /usr/bin/swig3.0 /usr/bin/swig

COPY ./requirements.txt .

RUN pip3 install --upgrade pip==21.0.1 && \
    pip3  install --no-deps -r requirements.txt && \
    python3 -m ipykernel.kernelspec


EXPOSE 8888
VOLUME /notebooks
WORKDIR /notebooks

COPY run_jupyter.sh /
CMD ["/run_jupyter.sh"]
