# remnux-sift

## Description
This Docker image contains the latest version of REMnux and SIFT toolkits on Ubuntu 20.04 (focal).
REMnux®, created by Lenny Zeltser, is a toolkit for reverse-engineering and analyzing malware.
SIFT, created by Rob Lee, is a toolkit for investigating memory, network, registry, and file system.
This image combines the toolkits together to help forensics investigators use them in one place. The Dockerfile of this image is included in this GitHub repository and the final image of this Dockerfile can be pulled from the Docker Hub: https://hub.docker.com/r/yara0/remnux-sift

## Maintainer
[yara0](https://github.com/yara0)

## Usage

Run the remnux-sift image as an interactive Docker Container:
```bash
$ sudo docker run -it yara0/remnux-sift bash
```

Run the remnux-sift image as an interactive Docker Container in the background:
```bash
$ sudo docker run -dit yara0/remnux-sift bash
```

Access the remnux-sift container that runs in the background:
```bash
$ sudo docker exec -it yara0/remnux-sift bash
```

Run the remnux-sift image as an interactive Docker Container in the background with shared(mounted) folder:

Note: 
- replace <local_folder> with the folder's path you want to mount as a shared folder.
- replace desired_container_name> with the name of your container. The name tag is optional and you can remove it. 
- In case you do not want to run it in the background, remove (d) option

```bash
$ sudo docker run --name=<desired_container_name> -dit -u remnux-sift -v <local_folder>:/home/remnux-sift/shared yara0/remnux-sift bash
```

Run the remnux-sift image as a Docker Container in the background and map local 22 port with the container's internal 22 port for SSH access.
```bash
$ docker run -d -p 22:22 yara0/remnux-sift
```
