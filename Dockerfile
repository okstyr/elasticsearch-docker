FROM ubuntu:14.04
run echo  sdfsdf
RUN apt-get update

RUN apt-get install -y curl unzip software-properties-common

RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update

RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

#RUN update-alternatives --config java
#RUN update-alternatives --config javac

RUN mkdir -p /app
WORKDIR /app

RUN curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.1.zip
RUN unzip elasticsearch-*.zip
RUN mv `ls -d elasticsearch*|egrep 'elasticsearch-[0-9.]+$'` elasticsearch

RUN elasticsearch/bin/plugin -i elasticsearch/marvel/latest
RUN echo 'marvel.agent.enabled: false' >> elasticsearch/config/elasticsearch.yml

COPY run.sh run.sh
CMD ./run.sh
