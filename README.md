# Docker Jupyter Lab
Dockerfile and docker-compose files to build a Jupyter Lab image and run docker containers.

## Build from dockerfile

To build the image from the Dockerfile, simply run the following line in the terminal:

```console
$ docker build -t jupyter-lab --build-arg JUPYTER_PASS=StrongPassWord .
```
- `-t` is the option to add labels to the built image. For example *jupyter-lab*.
- `--build-arg` is the option to add values to arguments in build time. In this case, it is required to include a value to JUPYTER_PASS which will be the password to enter the jupyter workspace. 

Subsequently, it is possible to change the password. This is done by opening a terminal within the jupyter working environment and executing the following:

```console
$ jupyter lab password
```

## Run
To run a container with the previously constructed image, simply execute the following command:

```console
$ docker run -it -d --name jupyter -p 9000:9000 jupyter-lab
```
- `-it` allows the container to start in interactive mode.
- `-d` runs the container without attaching to it.
- `--name` gives the container a custom name.
- `-p` allows you to connect port of the localhost to port of the container. By default, the jupyter lab server listens on port 9000.

## Docker Compose
For lauch a service of Jupyter Lab, execute the following command:

```console
$ docker compose up -d
```
the above command will build the image from the Dockerfile and run a container. 

The default jupyter lab login password is ***abc123***, which can be changed directly in the `docker-compose.yml` file or in the console inside the jupyter lab workspace.

To stop the service, run:
```console
$ docker compose stop
```

To start the service, run:
```console
$ docker compose start
```

Finally, to stop and remove the service, execute:
```console
$ docker compose down
```

## Remote connection via SSH
If you run the containers on a remote server and need to work locally in the jupyter lab workspace, you need to access via SSH tunneling.

This is achieved by running on a terminal in the computer where you are going to work: 
```console
$ ssh -fN user@server -L 9000:localhost:9000
```
- `-f` sends the request to be executed in the background.
- `-N` runs remote connection without attaching to remote console.
- `-L` bind the local computer port to the remote server port where the jupyter lab service is listening.

Finally, we launch a web browser, access `localhost:9000` and enter the Jupyter Lab login page. 

We're ready to work!