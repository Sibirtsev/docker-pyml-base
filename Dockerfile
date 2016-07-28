FROM ubuntu:16.04
MAINTAINER Alexey Sibirtsev <alexey.sibirtsev@gmail.com>

RUN apt-get -y update && \
apt-get install -y \
  python \
  python-dev \
  python-pip \
  python-all-dev \
  libblas-dev \
  liblapack-dev \
  gfortran \
  libjpeg8-dev \
  libfreetype6-dev \
  libxft-dev \
  libpng12-dev \
  libagg-dev \
  git \
  make \
  cmake \
  build-essential \
  libboost-all-dev \
  wget \
&& apt-get clean all

RUN apt-get install python-setuptools

RUN pip install --upgrade pip

RUN pip install Cython

# install base packages
RUN pip install \
  numpy \
  scipy \
  pandas \
  scikit-learn \
  matplotlib \
  seaborn \
  ggplot \
  statsmodels

# install jupyter
RUN pip install jupyter

# install http & db packages
RUN pip install \
  beautifulsoup4 \
  requests \
  pymysql \
  pymongo

# install additional math packages
RUN pip install \
  h5py \
  patsy \
  sympy

# install xgboost
RUN cd ~
RUN git clone --recursive https://github.com/dmlc/xgboost
WORKDIR xgboost
RUN make
RUN cd python-package; python setup.py install

RUN mkdir /data
WORKDIR /data
VOLUME ["/data"]

EXPOSE 8888

ENTRYPOINT ["sh", "-c", "jupyter notebook --no-browser --ip='*'"]
