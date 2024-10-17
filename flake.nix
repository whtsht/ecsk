{
  description = "Flake to install ecsk";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }: {
    packages.x86_64-linux.ecsk = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      version = "0.9.3";
      src = pkgs.fetchurl {
        url = "https://github.com/yukiarrr/ecsk/releases/download/v${version}/ecsk_Linux_x86_64.tar.gz";
        sha256 = "0gl12pw8dqrc9p7qnxqnzzdd7grn0p1sv6xps62pbi5yrrasjpag";
      };
    in
    pkgs.stdenv.mkDerivation {
      pname = "ecsk";
      inherit version src;

      unpackPhase = ''
        mkdir -p $out/bin
        tar -xzf $src -C $out/bin
        chmod +x $out/bin/ecsk
      '';

      meta = with pkgs.lib; {
        description = "ECS + Task = ecsk 😆";
        license = licenses.mit;
      };
    };
  };
}
