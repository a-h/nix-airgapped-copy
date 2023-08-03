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
wget https://github.com/NixOS/nixpkgs/archive/f9c5d92b43cc0c496f35f073386300e564e9939a.tar.gz
tar xf f9c5d92b43cc0c496f35f073386300e564e9939a.tar.gz
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

### export-custom-flake

Requires: create-docker-nixpkgs-offline

Here we can export the flake by `cd /github-runner` and `nix copy --all --to file:///home/nix/export`.

It's possible to override the flake inputs and use local disk paths.

The build closure can be copied (as per https://determinate.systems/posts/moving-stuff-around-with-nix) - `nix copy --derivation --to file:///home/nix/export`

```
docker run -it --rm -v `pwd`/export:/home/nix/export -v /home/adrian-hesketh/github.com/example-pipeline/github-runner/:/github-runner nixpkgs-offline
```

### run-custom-flake

Requires: create-docker-nixpkgs-offline

Here we can import the flake with `nix copy --all --from file:///home/nix/export --no-check-sigs`.

If the package is called `example-pipeline-github-runner` then you can find the packages that belong to it by querying the nix store - `ls /nix/store | grep github-runner`.

`example-pipeline-github-runner` installs things that are from nixpkgs - you can run them air-gapped with `nix run nixpkgs#jq` and it won't try to download them because they're already in the store

You can also install all of the outputs of the flake, after the copy operation, run `nix profile install <output_of_store_location>`.

```
docker run -it --rm --network none -v `pwd`/export:/home/nix/export -v /home/adrian-hesketh/github.com/example-pipeline/github-runner/:/github-runner nixpkgs-offline
```
