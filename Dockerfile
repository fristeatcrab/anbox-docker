FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
# hadolint ignore=DL3008
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  build-essential \
  cmake \
  cmake-data \
  cmake-extras \
  debhelper \
  dbus \
  git \
  google-mock \
  libboost-dev \
  libboost-filesystem-dev \
  libboost-log-dev \
  libboost-iostreams-dev \
  libboost-program-options-dev \
  libboost-system-dev \
  libboost-test-dev \
  libboost-thread-dev \
  libcap-dev \
  libegl1-mesa-dev \
  libgles2-mesa-dev \
  libglm-dev \
  libgtest-dev \
  liblxc1 \
  libproperties-cpp-dev \
  libprotobuf-dev \
  libsdl2-dev \
  libsdl2-image-dev \
  libsystemd-dev \
  lxc-dev \
  pkg-config \
  protobuf-compiler && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y python2 ninja-build libgmock-dev ca-certificates

RUN git clone --recurse-submodules --progress https://github.com/anbox/anbox /anbox
WORKDIR /anbox
RUN cmake -B build \
        -DCMAKE_BUILD_TYPE=Release \
        -DBINDERFS_PATH=/var/lib/binderfs \
        -GNinja \
    && \
    mkdir -p build/gmock && \
    ln -sf \
        /usr/lib/x86_64-linux-gnu/libgmock.a \
        /usr/lib/x86_64-linux-gnu/libgmock_main.a \
        build/gmock \
    && \
    cmake --build build && \
    cmake --install build && \
    rm -rf build
WORKDIR /
COPY launcher.sh /anbox-container-manager
RUN chmod +x /anbox-container-manager
