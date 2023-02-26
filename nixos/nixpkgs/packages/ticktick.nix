{ lib, stdenv, dpkg, fetchurl }:
let
  version = "1.0.60";
  pname = "ticktick";
in

stdenv.mkDerivation {
  inherit version pname;

  src = fetchurl {
    url = "https://appest-public.s3.amazonaws.com/download/linux/linux_deb_x64/${pname}-${version}-amd64.deb";
    # hash = "sha256-JI0H25Bu7uk3ASMo65Gv1YxPc9tC+tAb7M7wFPMyvxk=";
    # hash = "sha256:06dz6bri9w6fxhdx1yj2vdrlz36mmy8yna1304vykvkfj3dhg394";
    # hash = "sha256:183rnh965nxn5vzkgn2q087j0lzi6ly1jg5w3q44zgc8jrgzxyc8";
    # hash = "sha256:1l8fxx7p2bg7fck2da9cj0g1xx9ql32v5hyqxjkwarv0xz0fv24f";
    hash = "sha256-ZN8xOHM5HXgDjVRl8c6vsQXct0qhZ1uDff/nXc96tWg=";
  };

  dontBuild = true;
  buildInputs = [ dpkg ];

  unpackPhase = ''
    mkdir -p $out
    dpkg -x $src $out
  '';

  installPhase = ''
  '';

  meta = with lib; {
    homepage = "https://ticktick.com/";
    description = "Stay Organized Stay Creative";
    license = licenses.unfreeRedistributable;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}

