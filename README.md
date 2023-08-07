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
wget https://github.com/NixOS/nixpkgs/archive/23.05.tar.gz
tar xf 23.05.tar.gz
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

On any machine, you can run `nix copy github:NixOS/nixpkgs/23.05#hello --to file:///home/adrian-hesketh/github.com/a-h/nix-airgapped-copy/export` to create an export.

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

### export-custom-flake-local

Dir: ./example-flake

```
nix copy .# --derivation --to file:///home/adrian-hesketh/github.com/a-h/nix-airgapped-copy/export
nix copy .# --to file:///home/adrian-hesketh/github.com/a-h/nix-airgapped-copy/export
```

### export-custom-flake

Requires: create-docker-nixpkgs-offline

Here we can export the flake by `cd ./example-flake` and doing two `nix copy` operations. One to copy the derivation, one to copy the binary outputs, see `export-custom-flake-local`.

```
docker run -it --rm -v `pwd`/export:/home/nix/export -v `pwd`/example-flake/:/example-flake nixpkgs-offline
```

### run-custom-flake

Requires: create-docker-nixpkgs-offline

Here we can import the flake with `nix copy --all --from file:///home/nix/export --no-check-sigs --verbose`.

Then, we can build or run the custom flake by `cd /example-flake` and `nix build --override-input nixpkgs path:///dependencies/nixpkgs-23.05`.

```
docker run -it --rm --network none -v `pwd`/export:/home/nix/export -v `pwd`/example-flake/:/example-flake nixpkgs-offline
```
