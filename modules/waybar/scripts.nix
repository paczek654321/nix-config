{ config, lib, pkgs, ... }:
{

config = lib.mkIf config.my.waybar.enable
{
	my.wofi.enable = true;

	home-manager.users."${config.my.user.username}".home.packages = with pkgs;
	[
		killall
		(writeShellScriptBin "wofi_wifi.sh"
		''
			ssid=$(
				iwctl station wlan0 scan; iwctl station wlan0 get-networks |
				sed "1,4d; s/\x1b\[[0-9;]*[mGKH]//g; s/>//" |
				awk '{print $1}' |
				wofi --dmenu --prompt "Choose the network"
			)
			password=$(echo "" | wofi -d -P --prompt "Wifi Password")
			iwctl --passphrase "$password" station wlan0 connect "$ssid"
		'')

		(writeShellScriptBin "focused_backlight"
		''
			MONITOR=$(hyprctl monitors | awk '/Monitor/ {p=$2} /focused: yes/ {print p}')
			basename $(readlink /sys/class/drm/card*-$MONITOR/ddcci_backlight);
		'')
	];
};

}