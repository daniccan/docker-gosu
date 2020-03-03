## Docker-GoSu

Linux based Docker images with [gosu](https://github.com/tianon/gosu) support to run as non-root user.

### Usage

* Import the docker-gosu image as the base image in your Dockerfile.

```
FROM daniccan/ubuntu-gosu:latest

....
....
```

* To run your container as a non-privileged user.

```
docker run -it your-image
```

* To run your container as a non-privileged user with the same permissions as the host system user.

```
docker run -it -e LOCAL_USER_ID=`id -u $USER` your-image
```

### Supported Linux Distros

| Linux Distro         | Version(s)                                              |
|----------------------|---------------------------------------------------------|
| Ubuntu               | latest, 18.04 (bionic), 16.04 (xenial), 14.04 (trusty)  |

### Issues

Find any bugs or need additional features? Please don't hesitate to [create an issue](https://github.com/daniccan/docker-gosu/issues/new).

### License

MIT Copyright (c) 2020 [daniccan](https://github.com/daniccan)
