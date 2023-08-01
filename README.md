## Tasks

### download-installer

Dir: dependencies

```
wget https://releases.nixos.org/nix/nix-2.16.1/nix-2.16.1-x86_64-linux.tar.xz
tar --overwrite -xf nix-2.16.1-x86_64-linux.tar.xz
```

### download-nixpkgs

Dir: dependencies

```
git clone --branch 23.05 --depth 1 git@github.com:NixOS/nixpkgs.git
tar --overwrite -xf nixpkgs.tar.xz
```

### create-docker-nixpkgs-offline-base

```
docker build -t nixpkgs-base -f Dockerfile.base .
```

### create-docker-nixpkgs-offline

Requires: create-docker-nixpkgs-offline-base

```
docker build --network none -t nixpkgs-offline -f Dockerfile.offline .
```

### run

Requires: create-docker-nixpkgs-offline

```
docker run -it --rm --network none -v /nix/store:/remotestore:Z nixpkgs-offline
```

## Documentation

Setup nixpkgs to point at a local copy of the Nix repo from Github.

```
nix registry add nixpkgs /dependencies/nixpkgs/
```
