# Run C/C++ code in container, with Google Test and Valgrind.

- DockerHub: https://hub.docker.com/r/xanonymous/gtest-cpp-essential-env

## How to use

1. Add file into your project root: `.devcontainer/devcontainer.json`
    - https://github.com/Xanonymous-GitHub/gtestrin/blob/main/devcontainer.json
2. Install
   the [`Dev containers`](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   extension in vscode.
3. Click the green button in the lower right corner of vscode and select `open folder in Container...`
4. Find your project folder and open it. Please note that this folder is the project folder of step 1!

#### More details

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
