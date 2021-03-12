# code-container

Docker container based on Debian hosting https://github.com/cdr/code-server

## Important Security Information

This project essentially packages a release from [another repository](https://github.com/cdr/code-server) for convenience. Please check the latest version in that repository and compare that with teh version being built for this image. If you are not comfortable with any discrepancies, please do not use this image.

This solution assumes a private running environment and all authentication to the VSCode web interface have been disabled.

**_Important_**: Do not expose the running container directly to the Internet. This solution was intended for a PRIVATE and trusted networked environment.

HTTPS is not enabled. All network traffic is in the clear.

Telemetry and update checks have been disabled.

Commands below demonstrate how you can gain Terminal access to the running docker container. The image is based of Debian and you should therefore be able to use debian commands like `apt` if you need to install additional software. Just keep in mind that your packages will also be non-existent of you delete the container. A way to add additional packages on first run will be a feature I am considering - see the Feature Backlog at the end of this README.

My repositories are scanned by [Snyk](https://snyk.io/) and I will attempt to give attentions to issues as soon as possible, as and when they arise.

## Build

If you cloned this repository from GitHub, you can build the image with the following command:

```shell
docker build -t code-container .
```

## Running the Container

### Preparing a persistent projects directory:

Below is an example of creating a directory where all your projects will live. Even if you delete the container and images, any files you created or projects you worked on will still be available here.

```shell
mkdir -p $HOME/tmp/test-projects
```

### Running from Docker Hub:

```shell
docker pull nicc777/code-container
docker run --name codeserve -d -p 127.0.0.1:8081:8081 -v $HOME/tmp/test-projects:/code-user/projects nicc777/code-container
```

### Running a Custom Built Image:

```shell
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

### Other Considerations 

If you opt to use the persistent project directory, keep in mind that any solution specific files or directories should always be used from the VSCode IDE, since there may be incompatibilities from the perspective of your host system.

Examples of this include the creation of Python virtual environments or installing Node modules for a project. 

You may need a terminal in the running container to achieve these goals - refer to the sections below for getting access to a terminal.

## Getting a terminal in the running Docker container

```shell
docker exec -it codeserve bash
```

## Getting a terminal in VSCode

Press `CTRL`+`P` and then type `Terminal: Create New Integrated Terminal`

The first time, `zsh` will ask you to choose a option. Select either `1` or `2`. More info on [`zsh` can be found here...](https://www.zsh.org/)

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
* Custom `zsh` config
* Install [Oh My ZSH](https://ohmyz.sh/)
