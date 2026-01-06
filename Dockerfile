FROM ubuntu:24.04

ENV PIP_DISABLE_PIP_VERSION_CHECK=true
ENV DEBIAN_FRONTEND=noninteractive
ENV UV_SYSTEM_PYTHON=1

RUN apt-get update \
    && apt-get install --no-install-recommends -yq \
      build-essential \
      python3 \
      python3-dev \
      python3-pip \
      libpq-dev \
      make \
      curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Install uv and dependencies in one layer
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    /root/.local/bin/uv pip install --break-system-packages -e .

ENV PATH="/root/.local/bin:$PATH"

CMD ["make", "docker-run-production"]
