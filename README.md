# Statically linked sed

Statically linked [sed] container image with [Bash]

> ~ 1,3M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-sed:latest
ghcr.io/awesome-containers/static-sed:4.9

docker.io/awesomecontainers/static-sed:latest
docker.io/awesomecontainers/static-sed:4.9
```

Slim statically linked [sed] container image with [Bash] and packaged with [UPX]

> ~ 677K (578K bash)

```bash
ghcr.io/awesome-containers/static-sed:latest-slim
ghcr.io/awesome-containers/static-sed:4.9-slim

docker.io/awesomecontainers/static-sed:latest-slim
docker.io/awesomecontainers/static-sed:4.9-slim
```

[sed]: https://www.gnu.org/software/sed/
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_SED_IMAGE="$image" \
  --build-arg STATIC_SED_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
