# code-container

Docker container based on Debian hosting https://github.com/cdr/code-server

## Build

```shell
docker build -t code-container .
```

## Run

```shell
mkdir -p $HOME/tmp/test-projects
docker run --name codeserve -d -p 127.0.0.1:8081:8081 -v $HOME/tmp/test-projects:/code-user/projects code-container
```

## Getting a terminal

```shell
docker exec -it codeserve bash
```

## Installed Extensions

```text
Gruntfuggly.todo-tree
mhutchie.git-graph
ms-python.python
ms-toolsai.jupyter
ugross.vscode-react-snippets
```
