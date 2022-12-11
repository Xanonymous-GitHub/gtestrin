# syntax=docker/dockerfile:1

# For Xanonymous's AUN policy, we should always use the latest stable major version here.
ARG VARIANT=3
FROM alpine:${VARIANT} AS base

# [Option] Install zsh
ARG INSTALL_ZSH="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/
RUN apk update && ash /tmp/library-scripts/common-alpine.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" \
    && rm -rf /tmp/library-scripts

FROM base AS FINAL

# set arguments
ARG GTEST_BRANCH_OR_TAG=main

# move to zsh.
CMD [ "/bin/zsh" ]

# update & upgrade all installed packages
RUN apk update && \
    apk --no-cache add build-base valgrind clang lldb llvm gdb cmake make && \
    apk upgrade

# clone google test repo
RUN git clone --depth=1 -b $GTEST_BRANCH_OR_TAG -q https://github.com/google/googletest.git /googletest && \
    mkdir -p /googletest/build

# build google test
WORKDIR /googletest/build
RUN cmake .. ${CMAKE_OPTIONS} && make && make install && \
    mkdir -p /code && \
    rm -rf /googletest

WORKDIR /code
