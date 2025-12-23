FROM debian:stable-slim

# Install Ruby, Python, build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ruby-full \
    build-essential \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --break-system-packages prek

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

USER $USERNAME

ENV GEM_HOME=/home/${USERNAME}/.gem
ENV GEM_PATH=/home/${USERNAME}/.gem
ENV PATH=/home/${USERNAME}/.gem/bin:$PATH

# Install Jekyll and Bundler
RUN gem install bundler jekyll
