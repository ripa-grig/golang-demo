ARG GO_ALPINE_VERSION

# Build the manager binary
FROM golang:${GO_ALPINE_VERSION} as builder

WORKDIR /app
# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
RUN go mod download

# Copy the go source
COPY main.go main.go
COPY print/ print/
COPY operators/ operators/

# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -buildmode=pie -a -o manager main.go

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM alpine:3.17.3
ARG user=app
ARG group=app
ARG uid=1001
ARG gid=1001
#Create the user
RUN mkdir /app && \
    addgroup -g ${gid} ${group} && \
    adduser -u ${uid} -G ${group} -s /bin/sh -D ${user} && \
    chown -R ${user}:${group} /app
    
LABEL golang-builder=true
WORKDIR /app
COPY --chown=${user}:${group} --from=builder /app/manager .
USER ${user}

ENTRYPOINT ["/app/manager"]