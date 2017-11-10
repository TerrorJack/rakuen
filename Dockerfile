FROM ubuntu:artful

ENV LANG en_US.UTF-8
ADD config.yaml /root/.stack/config.yaml
ADD bootstrap.sh /tmp/bootstrap.sh
RUN sh /tmp/bootstrap.sh && rm /tmp/bootstrap.sh
ENV PATH /root/.local/bin:`/root/.local/bin/stack --no-terminal path --compiler-bin`:$PATH:/root/miniconda3/bin
