{ pkgs, ... }:

{
  awake = pkgs.writeShellScriptBin "awake" ''
    if [ ! -f "/sys/class/power_supply/AC0/online" ]; then
      echo "$(date) - AC not available (awake)" >> /var/log/power.log
      exit 1
    fi

    AC_STATUS=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/AC0/online)

    if [[ $AC_STATUS == "1" ]]; then
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=15000 --stapm-limit=15000 --fast-limit=25000 --power-saving &>/dev/null
      echo "$(date) - using AC profile (power management service)" >> /var/log/power.log
    else 
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=10000 --stapm-limit=10000 --fast-limit=10000 --power-saving &>/dev/null
      echo "$(date) - using BAT profile (power management service)" >> /var/log/power.log
    fi
  '';
  awake-udev = pkgs.writeShellScriptBin "awake-udev" ''

    if [ ! -f "/sys/class/power_supply/AC0/online" ]; then
      echo "$(date) - AC not available (awake)" >> /var/log/power.log
      exit 1
    fi

    AC_STATUS=$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/AC0/online)

    sleep 1m # needed for override the BIOS default setup
    if [[ $AC_STATUS == "1" ]]; then
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=15000 --stapm-limit=15000 --fast-limit=25000 --power-saving &>/dev/null
      echo "$(date) - using AC profile (awake-udev)" >> /var/log/power.log
    else 
      ${pkgs.ryzenadj}/bin/ryzenadj --tctl-temp=95 --slow-limit=10000 --stapm-limit=10000 --fast-limit=10000 --power-saving &>/dev/null
      echo "$(date) - using BAT profile (awake-udev)" >> /var/log/power.log
    fi
  '';
}

