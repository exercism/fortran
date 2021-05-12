FROM gitpod/workspace-full

# Install custom tools, runtime, etc.
USER root
RUN apt-get update && apt-get install -y gfortran && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
