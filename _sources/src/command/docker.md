# Docker

## On Ubuntu 20.04

### To install Docker

```sh
$ sudo apt update
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
$ apt-cache policy docker-ce
$ sudo apt install docker-ce
$ sudo systemctl status docker
```

### Executing the Docker Command Without Sudo

```sh
$ sudo usermod -aG docker ${USER}
$ su - ${USER}
$ groups
$ sudo usermod -aG docker {username}
```

## CLI

### Mount

```docker
$ docker run \
  --mount type=bind,source=/tmp,target=/usr
```

### Delete all containers

```docker
$ docker stop `docker ps -a -q`; docker rm `docker ps -a -q`
$ docker stop $(docker ps -q); docker rm $(docker ps -q -a); docker rmi $(docker images -q) --force
```
