FROM ubuntu:16.04

RUN apt-get update && apt-get install -y sudo
RUN apt-get install -y openjdk-8-jre

ENV JOGET_VERSION joget-enterprise-linux-6.0.20
ENV JOGET_VIRTUALHOST false
ENV ASPECTJ_VERSION aspectjweaver-1.6.12
ENV WFLOW_HOME /opt/joget/wflow/

ENV JAVA_OPTS -Xmx512m -Dwflow.home=${WFLOW_HOME}

COPY binary/${JOGET_VERSION}.tar.gz /opt/joget/
COPY run.sh /opt/joget/
RUN cd /opt/joget/ ; \
    tar xvfz ${JOGET_VERSION}.tar.gz ; \
    cd ${JOGET_VERSION}/ ; \
    mv *.* /opt/joget/ ; \
    mv * /opt/joget/ ; \
    rm -rf /opt/joget/${JOGET_VERSION}/ ; \
    rm /opt/joget/${JOGET_VERSION}.tar.gz

RUN \
    groupadd -r app ; \
    useradd -r -g app -d /home/app -c "Docker image user" app ; \
    echo "app:app" | chpasswd ; \
    usermod -aG 0 app ; \
    usermod -aG sudo app ; \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers ; \
    chmod +x /opt/joget/run.sh ; \
    chown -R app:0 /opt/joget ; \
    chmod -R g+rw /opt/joget

USER root

EXPOSE 8080

ENTRYPOINT ["/opt/joget/run.sh"]
CMD [""]