FROM golang:1.13 AS builder
RUN apt update && apt install -y git ca-certificates
COPY . $GOPATH/src/json2hat
WORKDIR $GOPATH/src/json2hat
RUN go get -d -v
RUN CGO_ENABLED=0 go build -ldflags '-extldflags "-static" -s -w' -o /go/bin/json2hat
# FROM scratch
FROM alpine
RUN apk add git
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /go/bin/json2hat /usr/bin/json2hat
