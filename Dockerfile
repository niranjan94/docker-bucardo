FROM debian:jessie

WORKDIR /install

RUN apt-get update && \
    apt-get install libdbix-safe-perl wget curl tar \
                    manpages bzip2 build-essential \
                    python-pip libpq-dev python-dev \
                    postgresql postgresql-client -y

RUN wget http://bucardo.org/downloads/Bucardo-5.5.0.tar.gz && \
    tar xvfz Bucardo-5.5.0.tar.gz && \
    cd Bucardo-5.5.0 && \
    perl Makefile.PL && \
    make && \
    make install

RUN pip install pgcli

WORKDIR /bucardo

RUN apt-get remove build-essential -y && \
    apt-get autoremove -y && \
    rm -rf /install

