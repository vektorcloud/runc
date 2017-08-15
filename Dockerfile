FROM quay.io/vektorcloud/go:dep AS build

ENV RUNC_VERSION v1.0.0-rc4
ENV TOOLS_VERSION v0.2.0

RUN apk add --no-cache \
  bash \
  libseccomp \
  libseccomp-dev \
  linux-headers \
  && mkdir -p $GOPATH/src/github.com/opencontainers \
  && cd $GOPATH/src/github.com/opencontainers \
  && git clone --depth=1 --branch="$RUNC_VERSION" https://github.com/opencontainers/runc.git \
  && git clone --depth=1 --branch="$TOOLS_VERSION" https://github.com/opencontainers/image-tools.git \
  && cd runc \
  && make \
  && mv -v runc /tmp/ \
  && cd ../image-tools \
  && make tool \
  && mv -v oci-image-tool /tmp/

FROM quay.io/vektorcloud/base:3.6

COPY --from=build /tmp/runc /usr/bin/
COPY --from=build /tmp/oci-image-tool /usr/bin/

RUN apk add --no-cache libseccomp \
  && mkdir /containers

WORKDIR /containers

