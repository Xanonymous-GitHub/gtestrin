# Run C/C++ code in container, with Google Test and Valgrind.

- DockerHub: https://hub.docker.com/r/xanonymous/gtest-cpp-essential-env

## How to use

1. Prepare a running container.

    ```shell
    docker run -d --pull always xanonymous/gtest-cpp-essential-env
    ```

2. Follow these steps to open folder inside container using vscode.

- https://code.visualstudio.com/docs/devcontainers/containers

## How to build

```shell
./distribute.sh
```

## How to update configs here

- Official config: https://github.com/devcontainers/images

Basically we use alpine's config for `Dockerfile`s, but use c++ and alpine's for `devcontainer.json`.
The `VARIANT` arg in `devcontainer.json` uses alpine's while others use c++'s.

Then, note that the `common-alpine.sh` should also be traced to upgrade too.

## TODO

- [ ] Add some vscode settings into `devcontainer.json`.
