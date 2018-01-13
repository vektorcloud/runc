# [Runc](https://github.com/opencontainers/runc) Alpine Image

![circleci][circleci]

## Usage

    mkdir -p ./busybox/rootfs
    docker export $(docker create busybox) | tar -C ./busybox/rootfs -xvf -
    docker run --rm -ti -v $PWD/busybox:/containers quay.io/vektorcloud/runc runc spec
    docker run --privileged --rm -ti -v $PWD/busybox:/containers/busybox quay.io/vektorcloud/runc runc run -b busybox bb

[circleci]: https://img.shields.io/circleci/project/github/vektorcloud/runc.svg "runc"
