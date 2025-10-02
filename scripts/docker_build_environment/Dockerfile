FROM ubuntu:14.04
# use 18.04 to enable CXX17
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y git fakeroot make g++ zlib1g-dev wget

RUN set -x \
    && wget https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1-linux-x86_64.tar.gz -O cmake.tar.gz \
    && tar xzf /cmake.tar.gz --directory=/usr/ --strip-components=1 \
    && rm cmake.tar.gz
