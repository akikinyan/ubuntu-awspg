FROM ubuntu:19.04
LABEL maintainer="akikinyan@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y install gnupg unzip curl

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``11``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ disco-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 11
#  There are some warnings (in red) that show up during the build. You can hide
#  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get install -y postgresql-11

# Install pkg
RUN apt-get -y install openjdk-11-jdk wget vim

# Install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
cd /tmp && unzip awscliv2.zip && \
./aws/install

# Entrypoint
# COPY docker-entrypoint.sh /usr/local/bin/
# RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
# ENTRYPOINT ["docker-entrypoint.sh"]
