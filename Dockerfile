FROM python:3-slim-buster

COPY entrypoint.sh /entrypoint.sh
COPY requirements.txt /tmp/requirements.txt

RUN apt-get update && \
 apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    expect \
    gcc \
    gnupg \
    jq \
    libcurl4-openssl-dev \
    libssl-dev \
    lsb-release \
    openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists && \
    chmod 755 /entrypoint.sh && \
    adduser --disabled-password --gecos '' ansible && \
    chown ansible:ansible /tmp/requirements.txt

USER ansible
WORKDIR /home/ansible

ENV PATH=/bin:/usr/bin:/usr/local/bin:/home/ansible/.local/bin
RUN pip3 install --user -r /tmp/requirements.txt && \
    rm -f /tmp/requrements.txt

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ansible-playbook", "--inventory=inventory.yml", "playbook.yml"]
