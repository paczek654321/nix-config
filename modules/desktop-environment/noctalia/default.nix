{ config, lib, inputs, self, pkgs, ... }:
let
	username = config.my.user.username;
in
{

imports = [ inputs.noctalia.nixosModules.default ];

config =
{
	programs.noctalia =
	{
		enable = true;
		recommendedServices.enable = true;
	};

	hardware.bluetooth.settings =
	{
		General.Experimental = true;
		Policy.AutoEnable = true;
	};

	services.ddccontrol =
	{
		enable = true;
		package = pkgs.ddcutil;
	};

	users.users."${username}".extraGroups = [ "networkmanager" "i2c" ];

	home-manager.users.${username} =
	{
		imports = [ inputs.noctalia.homeModules.default ];

		programs.noctalia =
		{
			enable = true;
			settings = ./config.toml;
		};
	};
};

}