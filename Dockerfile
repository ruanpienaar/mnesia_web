FROM alpine:latest
ENV RUN_ERL_LOG_ALIVE_MINUTES=60
ENV RUN_ERL_LOG_MAXSIZE=10000000
ARG NODENAME=node
ARG COOKIE=cookie
ENV NODENAME=${NODENAME}
ENV COOKIE=${COOKIE}
RUN apk --update add make \
    erlang erlang-crypto erlang-mnesia erlang-asn1 erlang-public-key \
    erlang-ssl erlang-inets erlang-sasl erlang-syntax-tools erlang-observer \
    erlang-runtime-tools \
    git && \
    git clone https://github.com/ruanpienaar/mnesia_cluster
WORKDIR mnesia_cluster
ADD cluster.sys.config .
RUN mkdir pipe/
CMD make && \
    epmd -daemon && \
    erl -sname ${NODENAME} -setcookie ${COOKIE} -config cluster.sys.config -pa $PWD/_build/default/lib/*/ebin -s mnesia_cluster start -boot start_sasl