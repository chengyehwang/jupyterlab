FROM ubuntu:19.10
MAINTAINER ChengYehWang
RUN apt update 
RUN apt install wget python -y
RUN wget http://get.perfetto.dev/trace_processor
RUN chmod 755 trace_processor
RUN ./trace_processor --help
