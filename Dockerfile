FROM lambci/lambda:build-python3.7
MAINTAINER Ingo Müller <ingo.mueller@inf.ethz.ch>

ARG RUST_VERSION=1.51.0
ARG RUSTUP_VERSION=1.24.0

# Packages
RUN touch /var/lib/rpm/* && \
    yum install -y \
        # General
        wget \
        && \
    yum -y clean all

# Rust configuration
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=${RUST_VERSION}

# Install rust
RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/x86_64-unknown-linux-gnu/rustup-init"; \
    wget --progress=dot:giga "$url"; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
