ARG CNPG_TAG=17.6-bookworm

FROM ghcr.io/cloudnative-pg/postgresql:${CNPG_TAG}

ARG PG_MAJOR
ENV PG_MAJOR=${PG_MAJOR}

USER root
RUN apt update && apt-get install -y --no-install-recommends \ 
    lsb-release wget \
    && wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb \
    && apt-get install -y ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb \
    && wget https://packages.groonga.org/debian/groonga-apt-source-latest-$(lsb_release --codename --short).deb \
    && apt-get install -y ./groonga-apt-source-latest-$(lsb_release --codename --short).deb 

RUN apt update && apt-get install -y --no-install-recommends \
    "postgresql-$PG_MAJOR-pgdg-pgroonga" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

USER postgres