let 
  pkgs = (import <nixpkgs> {});#.pkgsCross.aarch64-multiplatform;
in
pkgs.dockerTools.buildImage {
  name = "red-button-dns";
  contents = [
    pkgs.mosquitto
    pkgs.bashInteractive
    pkgs.adguardhome
    pkgs.hello
    pkgs.busybox
  ];
  config = {
    Cmd = [ "${pkgs.hello}/bin/hello" ];
  };
}
