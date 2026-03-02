FROM rust:1.93-bookworm AS builder
WORKDIR /src

COPY . .

ENV RUST_BACKTRACE=1

RUN cargo build --release


FROM debian:bookworm-slim
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/target/release/rustscan /usr/local/bin/rustscan
ENTRYPOINT ["rustscan"]
