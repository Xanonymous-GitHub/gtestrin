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
RUN apk update && \
    ash /tmp/library-scripts/common-alpine.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" && \
    rm -rf /tmp/library-scripts && \
    apk --no-cache add build-base valgrind gtest gtest-dev clang lldb llvm gdb cmake make && \
    apk upgrade

WORKDIR /workspaces

# move to zsh.
SHELL ["/bin/zsh"]

# make the container stay running.
CMD [ "tail", "-f", "/dev/null"]
