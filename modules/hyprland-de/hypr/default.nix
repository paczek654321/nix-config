{ config, pkgs, lib, ... }:
let
	username = config.my.user.username;
in
{

imports =
[
	./hyprlock.nix
	./hypridle.nix
	./hyprpaper.nix
	./hyprpolkitagent.nix
	./hyprshot.nix
	./hyprpicker.nix
];

}
