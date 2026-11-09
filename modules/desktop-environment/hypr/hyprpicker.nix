{ config, pkgs, lib, ... }:
{

config = lib.mkIf config.my.hyprland.enable
{
	environment.systemPackages = with pkgs; [ hyprpicker wl-clipboard-rs ];
	my.hyprland.settings.bind = [ "$mainMod, Z, exec, wl-copy $(hyprpicker)" ];
};

}
