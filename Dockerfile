FROM golang:latest

RUN \
    apt update && \
    apt -y upgrade && \
    apt install -y supervisor

WORKDIR /go/src

COPY ./main.go ./
COPY ./go.mod ./

ARG GOOS=linux
ARG GOARCH=amd64
RUN go build 
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD [ "/usr/bin/supervisord" ]
