{ config, pkgs, lib, ... }:
{

options.my.hyprpicker.enable = lib.mkEnableOption "Enable hyprpicker";

config = lib.mkIf config.my.hyprpicker.enable
{
	environment.systemPackages = with pkgs; [ hyprpicker wl-clipboard-rs ];
};

}
