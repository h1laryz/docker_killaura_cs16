# Docker image for cs 1.6 servers made with Ubuntu 24.10

## Docker image

``` bash
docker pull ghcr.io/h1laryz/killaura-cs16-server:latest
```

## Env variables

``` bash
export KILLAURA_CS16_DEFAULT_MAP="de_dust2"
export KILLAURA_CS16_LAUNCH_PARAMS="+sv_lan 0"
```

## Run container

``` bash
mkdir -p ~/cs16 && \
sudo chown 1001:1001 ~/cs16

docker run --rm --name killaura-cs16-server \
  -v ~/cs16/:/home/container/cs \
  -e KILLAURA_CS16_LAUNCH_PARAMS="$KILLAURA_CS16_LAUNCH_PARAMS" \
  -e KILLAURA_CS16_DEFAULT_MAP="$KILLAURA_CS16_DEFAULT_MAP" \
  -p 27015:27015/udp -p 27015:27015/tcp \
  ghcr.io/h1laryz/killaura-cs16-server:latest
```
