# This Dockerfile have 3 stage, one for dev usage with hot reload, 
# one for building the production binary and one production image with minimal dependancies.
# You should update the port exposed and the name of the binary used for you case.

FROM rust:1.99 AS dev
WORKDIR /app
RUN cargo install bacon

EXPOSE 3001
ENTRYPOINT ["bacon", "run-long", "--headless"]

FROM rust:1.99 AS builder
WORKDIR /app
# This allow to compile a rust binary with static linked libc, required for "scratch" image which don't have libc installed.
RUN rustup target add x86_64-unknown-linux-musl
# this allow to cache rust deps build to avoid downloading them over and over.
RUN mkdir -p  src/bin && echo "fn main() {}" > src/bin/dummy.rs
COPY Cargo.toml .
RUN cargo build --release --target=x86_64-unknown-linux-musl
RUN rm src/bin/dummy.rs

# Here we copy our real code and compile it.
COPY . .
RUN cargo build --release --target=x86_64-unknown-linux-musl

FROM scratch AS prod
WORKDIR /app
# Copy the executable we need in small image, to avoid having all rust deps (2GB) in final image.
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/rust-hot-reload /app/rust-hot-reload
EXPOSE 3001
ENTRYPOINT ["/app/rust-hot-reload"]
