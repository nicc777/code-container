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

The extensions first need to be installed, which can take a minute or so. You can check when the server is ready by tailing the logs:

```shell
docker logs -f codeserve
Starting the code-server
/opt/bin/code-service-starter.sh: 4: cd: can't cd to /code-server/projects
[2021-03-12T06:42:28.397Z] info  Wrote default config file to ~/.config/code-server/config.yaml
Installing extensions...
Installing extension 'gruntfuggly.todo-tree' v0.0.202...
Extension 'gruntfuggly.todo-tree' v0.0.202 was successfully installed.
Installing extensions...
  .
  .
  .
[2021-03-12T06:42:56.920Z] info  HTTP server listening on http://0.0.0.0:8081
```

By the time you see the last line above, the server is pretty much up. There may very well be some additional output after that line - that is fine. Unless of course you observe an error in the output - that may be a problem.

## Getting a terminal

```shell
docker exec -it codeserve bash
```

## Installed Code Extensions

```text
Gruntfuggly.todo-tree
mhutchie.git-graph
ms-python.python
ms-toolsai.jupyter
ugross.vscode-react-snippets
```

## Installed Packages

* Python3
* Git
* Node (v14)
* AWS CLI

## Feature Backlog

* Customize the installed packages at build time
* Customize the Extensions and build time
