# syntax=docker/dockerfile:1

# For Xanonymous's AUN policy, we should always use the latest stable major version here.
ARG VARIANT=edge
FROM alpine:${VARIANT} AS base

# [Option] Install zsh
ARG INSTALL_ZSH="true"

# Setup ENV vars for vcpkg
ENV VCPKG_ROOT=/usr/local/vcpkg \
    VCPKG_DOWNLOADS=/usr/local/vcpkg-downloads
ENV PATH="${PATH}:${VCPKG_ROOT}"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/
RUN apk update && \
    ash /tmp/library-scripts/common-alpine.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" && \
    ash /tmp/library-scripts/install-vcpkg.sh ${USERNAME} && \
    rm -rf /tmp/library-scripts && \
    apk --no-cache add  \
    valgrind  \
    gtest  \
    gtest-dev  \
    sdl2  \
    sdl2-dev  \
    sdl2_image  \
    sdl2_image-dev  \
    sdl2_mixer  \
    sdl2_mixer-dev  \
    sdl2_ttf  \
    sdl2_ttf-dev  \
    boost  \
    boost-dev  \
    cppcheck  \
    gdb  \
    && \
    apk upgrade

WORKDIR /workspaces

# move to zsh.
SHELL ["/bin/zsh"]

# make the container stay running.
CMD [ "tail", "-f", "/dev/null"]
