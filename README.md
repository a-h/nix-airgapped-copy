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

On any machine, you can run `nix copy github:NixOS/nixpkgs/23.05#hello --to file:///home/adrian-hesketh/Downloads/nixpkgs/export` to create an export.

Then you can import it with `nix copy --all --from file:///home/nix/export`

Once that's done, you can run the program with `nix run nixpkgs#hello`.

```
docker run -it --rm --network none -v `pwd`/export:/home/nix/export nixpkgs-offline
```

### export

Requires: create-docker-nixpkgs-offline

If you don't have Nix installed, you can export a Nix Flake from a machine with Internet access using `nix copy --to file:///home/nix/export nixpkgs#hello`

The machine will download everything that's required.

```
docker run -it --rm -v `pwd`/export:/home/nix/export nixpkgs-offline
```

