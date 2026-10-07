FROM golang:latest AS builder

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
#RUN go build  -v -o /usr/local/bin/app ./...
RUN go build --ldflags '-linkmode external -extldflags "-static"' -v -o /usr/local/bin/app ./...

FROM scratch AS runner
COPY --from=builder /usr/local/bin/app /usr/local/bin/app

COPY public public

EXPOSE 3000
CMD ["/usr/local/bin/app"]
