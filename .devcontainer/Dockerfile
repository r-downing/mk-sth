FROM debian:stable-slim

# Install Ruby, Python, build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ruby-full \
    build-essential \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Jekyll and Bundler
RUN gem install bundler jekyll

RUN pip install --no-cache-dir --break-system-packages uv

RUN uv tool install --no-cache pre-commit
