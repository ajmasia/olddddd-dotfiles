self: super: {
  insync_3_8_5 = self.callPackage ../packages/insync.nix {
    inherit (super) lib writeShellScript stdenv fetchurl autoPatchelfHook dpkg nss libvorbis libdrm libGL wayland libthai;
    buildFHSEnv = super.buildFHSUserEnv;
  };
}
