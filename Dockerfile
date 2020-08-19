FROM lambci/lambda:build-python3.7
MAINTAINER Ingo Müller <ingo.mueller@inf.ethz.ch>

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
    RUST_VERSION=1.45.2

# Install rust
RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/1.22.1/x86_64-unknown-linux-gnu/rustup-init"; \
    wget --progress=dot:giga "$url"; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
