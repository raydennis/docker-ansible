# NOTE!! user should be replaced with your username.  It should match the username of your host machine.
# HowTO Build
# $ docker build -t ansible --build-arg LUSER=user .
# HowTo Run
# $ docker run -v /home/user/.ssh:/home/user/.ssh -it ansible 
FROM centos:7

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV http_proxy http://proxy-dmz.intel.com:911
ENV https_proxy http://proxy-dmz.intel.com:911

ARG LUSER

RUN useradd -m $LUSER
RUN mkdir -p /home/$LUSER/.ssh
RUN chown -R $LUSER:$LUSER /home/$LUSER/.ssh

RUN yum check-update; \
    yum install -y bind-utils; \
    yum install -y gcc libffi-devel python3 epel-release; \
    yum install -y netcat; \
    yum install -y openssh-clients; \
    yum install -y python3-pip; \
    yum install -y wget; \
    yum clean all

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
