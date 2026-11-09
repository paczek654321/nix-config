{ config, lib, pkgs, ... }:
let
	username = config.my.user.username;
in
{

options.my.syncthing.enable = lib.mkEnableOption "Enable syncthing";

config = lib.mkIf config.my.syncthing.enable
{
	services.syncthing =
	{
		enable = true;
		openDefaultPorts = true;
		user = username;
		dataDir = "/home/${username}";
	};
};

}