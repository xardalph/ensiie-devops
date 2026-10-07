FROM golang:latest AS builder

WORKDIR /usr/src/app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
#RUN go build  -v -o /usr/local/bin/app ./...
RUN go build --ldflags '-linkmode external -extldflags "-static"' -v -o /usr/local/bin/app ./...

FROM builder AS dev 
RUN go install github.com/air-verse/air@latest

COPY main.go .
COPY public public
COPY air.toml .

EXPOSE 3000
CMD ["air", "-c", "air.toml"]


FROM scratch AS prod
COPY --from=builder /usr/local/bin/app /usr/local/bin/app
COPY --from=builder /usr/bin/curl /usr/bin/curl

# smaller healtchcheck from https://github.com/tarampampam/microcheck
#COPY --from=ghcr.io/tarampampam/microcheck:1 /bin/httpcheck /bin/httpcheck
#HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD ["httpcheck", "http://localhost:3000/"]
COPY public public

EXPOSE 3000
CMD ["/usr/local/bin/app"]
