{ config, pkgs, lib, ... }:
let
	username = config.my.user.username;
in
{

config = lib.mkIf config.my.hyprland.enable
{
	home-manager.users."${username}".home.packages = with pkgs; [ hyprpicker wl-clipboard-rs ];
	my.hyprland.settings.bind = [ "$mainMod, Z, exec, wl-copy $(hyprpicker)" ];
};

}
