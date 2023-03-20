{ pkgs ? import (fetchTarball https://github.com/nixos/nixpkgs/archive/8cbb2272316b0bfb95ec2223baba437107b0dd27.tar.gz) {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.terraform
    pkgs.google-cloud-sdk
    pkgs.ansible
   ];
}
