# Build stage
FROM rust:1.69-buster as builder

WORKDIR /app

# accept the build argumment
ARG DATABASE_URL

# make sure to use agg in env
ENV DATABASE_URL=$DATABASE_URL

# Copy the source code 
COPY . .

RUN cargo build --release

# production stage
FROM debian:buster-slim

WORKDIR C:\Program Files\Docker\Docker\resources\bin

COPY --from=builder /app/target/release/rust-crud-api .

CMD ["./rust-crud-api"]