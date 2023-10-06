# Alpine :: pwsh
![size](https://img.shields.io/docker/image-size/11notes/pwsh/7.2.10?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/pwsh?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/pwsh?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-pwsh?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-pwsh?color=c91cb8)

Run pwsh based on Alpine Linux. Small, lightweight, secure and fast 🏔️

## Volumes
* **/pwsh/bin** - Directory of your powershell installation
* **/pwsh/lib** - Directory of your powershell modules

## Run
```shell
docker run --name pwsh \
  -d 11notes/pwsh:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /pwsh | home directory of user docker |

## Parent
* [11notes/alpine:stable](https://github.com/11notes/docker-alpine)

## Built with and thanks to
* [pwsh](https://github.com/PowerShell/PowerShell)
* [Alpine Linux](https://alpinelinux.org/)

## Tips
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)