{
  description = "Flake to install ecsk";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }: {
    packages = {
      x86_64-linux.ecsk = buildEcs "x86_64-linux";
      aarch64-linux.ecsk = buildEcs "aarch64-linux";
    };
  };

  buildEcs = system: let
    pkgs = nixpkgs.legacyPackages.${system};

    version = "0.9.3";
    src = pkgs.fetchurl {
      url = "https://github.com/yukiarrr/ecsk/releases/download/v${version}/ecsk_Linux_${system}.tar.gz";
      sha256 = "0gl12pw8dqrc9p7qnxqnzzdd7grn0p1sv6xps62pbi5yrrasjpag";
    };
  in
  pkgs.stdenv.mkDerivation {
    pname = "ecsk";
    inherit version src;

    unpackPhase = ''
      mkdir -p $out/bin
      tar -xzf ${src} -C $out/bin --strip-components=1
      chmod +x $out/bin/ecsk
    '';

    meta = with pkgs.lib; {
      description = "ECS + Task = ecsk 😆";
      license = licenses.mit;
    };
  };
}
