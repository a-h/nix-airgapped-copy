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

### create-docker

```
docker build --network none -t nixpkgs-offline .
```

### run

Requires: create-docker

```
docker run --privileged -it --rm --workdir=/dependencies --network none -v /nix/store:/remotestore:Z nixpkgs-offline
```

