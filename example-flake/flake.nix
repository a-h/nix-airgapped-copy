{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
  };

  outputs = { self, nixpkgs }: {
    packages."x86_64-linux".default = let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      hello-nix-build = pkgs.stdenv.mkDerivation {
	pname = "hello-nix-build";
	version = "v0.0.1";
	src = ./hello-nix-build;
	buildInputs = [ pkgs.bash ];
	nativeBuildInputs = [ pkgs.makeWrapper ];
	installPhase = ''
          mkdir -p $out/bin
          cp hello-nix-build.sh $out/bin/hello-nix-build.sh
          chmod +x $out/bin/hello-nix-build.sh
	'';
      };
      in pkgs.buildEnv {
        name = "hello-nix-build";
        paths = [ hello-nix-build ];
      };
  };
}
