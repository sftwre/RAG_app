#!/bin/bash
# Install postgres
apt-get update && apt-get install -y wget ca-certificates && apt-get install -y sudo vim git
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
apt-get install -y postgresql postgresql-contrib
# Install pgvector
apt-get install -y postgresql-server-dev-all
pushd /tmp && git clone --branch v0.4.4 https://github.com/pgvector/pgvector.git && pushd pgvector && make && make install && popd && popd
# Activate pgvector and the database
echo 'ray ALL=(ALL:ALL) NOPASSWD:ALL' | tee /etc/sudoers
echo 'postgres ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
echo 'root  ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
service postgresql start
# pragma: allowlist nextline secret
sudo -u postgres psql -c "ALTER USER postgres with password 'postgres';"
sudo -u postgres psql -c "CREATE EXTENSION vector;"