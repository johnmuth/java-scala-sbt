FROM anapsix/alpine-java:8

RUN apk add --no-cache --update curl nodejs nodejs-npm
RUN npm install -g grunt-cli

ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.11

# Install Scala
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

ENV PATH=/usr/local/sbt/bin:$PATH

WORKDIR /usr/src/app

RUN sbt

