FROM golang as builder

WORKDIR /go/src/github.com/uswitch/ls-metrics
COPY . /go/src/github.com/uswitch/ls-metrics/
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build .

FROM scratch
LABEL maintainer Piotr Komborski <piotr.komborski@uswitch.com>
COPY --from=builder /go/src/github.com/uswitch/ls-metrics/ls-metrics /ls-metrics
ENTRYPOINT ["/ls-metrics"]
