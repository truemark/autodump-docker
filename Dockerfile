FROM debian:bookworm as base
ENV DEBIAN_FRONTEND="noninteractive" \
  APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=true

RUN apt-get -qq update &&  apt-get -qq --no-install-recommends install curl gnupg ca-certificates && \
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
  curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get -qq update && apt-get -qq --no-install-recommends install postgresql-client-10 postgresql-client-11 postgresql-client-12 postgresql-client-13 postgresql-client-14 postgresql-client-15 postgresql-client-16 && \
  apt-get -qq clean autoclean && apt-get -qq autoremove && rm -rf /var/lib/apt/lists/*

COPY /dumpdb.sh /usr/local/bin/dumpdb.sh

ENTRYPOINT [ "/user/local/bin/dumpdb.sh" ]
