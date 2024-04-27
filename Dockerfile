FROM python:3.10-bookworm

# install python
RUN apt-get update -y && apt-get install -y python3-pip

WORKDIR /usr/src/app/

COPY . .

# install project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# setup postgres db
RUN ./setup-pgvector.sh

EXPOSE 8888

ENTRYPOINT ["/bin/bash"]