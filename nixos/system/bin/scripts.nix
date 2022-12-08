{ pkgs, ... }:

{
  awake = pkgs.writeShellScriptBin "awake" ''
    echo "$(date) Awake" >> /home/ajmasia/udev.log

    if [ ! -f "/sys/class/power_supply/AC0/online" ]; then
      exit 1
    fi

    AC_STATUS=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/AC0/online)

    sleep 10 # needed for override the BIOS default setup
    if [[ $AC_STATUS == "1" ]]; then
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=15000 --stapm-limit=15000 --fast-limit=25000 --power-saving &>/dev/null
    else 
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=10000 --stapm-limit=10000 --fast-limit=10000 --power-saving &>/dev/null
    fi
  '';
  awake-udev = pkgs.writeShellScriptBin "awake-udev" ''

    if [ ! -f "/sys/class/power_supply/AC0/online" ]; then
      exit 1
    fi

    AC_STATUS=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/AC0/online)

    sleep 30 # needed for override the BIOS default setup
    if [[ $AC_STATUS == "1" ]]; then
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=15000 --stapm-limit=15000 --fast-limit=25000 --power-saving &>/dev/null
    else 
      echo "$(date) Awake UDEV" >> /home/ajmasia/udev.log
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=10000 --stapm-limit=10000 --fast-limit=10000 --power-saving &>/home/ajmasia/udev.log
    fi
  '';
}

