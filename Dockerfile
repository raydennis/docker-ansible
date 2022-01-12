# NOTE!! user should be replaced with your username.  It should match the username of your host machine.
# HowTO Build
# $ docker build -t ansible --build-arg LUSER=user .
# HowTo Run
# $ docker run -v /home/user/.ssh:/home/user/.ssh -it ansible 
FROM ubuntu:20.04

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV http_proxy http://proxy-dmz.intel.com:911
ENV https_proxy http://proxy-dmz.intel.com:911

ARG LUSER

RUN useradd -m $LUSER
RUN mkdir -p /home/$LUSER/.ssh
RUN chown -R $LUSER:$LUSER /home/$LUSER/.ssh

RUN apt update; \
    apt install -y bind-utils; \
    apt install -y gcc libffi-devel python3 epel-release; \
    apt install -y netcat; \
    apt install -y openssh-clients; \
    apt install -y python3-pip; \
    apt install -y wget; \
    apt-get clean

RUN pip3 install --upgrade pip; \
    pip3 install --upgrade virtualenv; \
    pip3 install pywinrm[kerberos]; \
    pip3 install pywinrm; \
    pip3 install jmspath; \
    pip3 install requests; \
    python3 -m pip install ansible

    # Example of installing roles from a collection.  
    # TODO: add appropriate DCO roles here
    # ansible-galaxy collection install azure.azcollection; \
    # pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

USER $LUSER
