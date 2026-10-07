FROM golang:latest

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download

COPY public public
COPY main.go .
RUN go build  -v -o /usr/local/bin/app ./...
#RUN go build --ldflags '-linkmode external -extldflags "-static"' -v -o /usr/local/bin/app ./...

EXPOSE 3000
RUN useradd -ms /bin/bash  goapp
USER goapp
CMD ["app"]
