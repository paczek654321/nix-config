{ config, lib, inputs, ... }:
let
	username = config.my.user.username;
in
{

imports =
[
	inputs.home-manager.nixosModules.default
];

options.my.user =
{
	enable = lib.mkEnableOption "User configuration via home manager";
	username = lib.mkOption
	{
		type = lib.types.str;
		default = "user";
		description = "Username for the primary user";
	};
};

config = lib.mkIf config.my.user.enable
{
	users.users."${username}" =
	{
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "wheel" ];
	};

	home-manager.useGlobalPkgs = true;
	
	home-manager.users."${username}" =
	{
		programs.home-manager.enable = true;
		home.stateVersion = "25.11";
		home.username = username;
		home.homeDirectory = "/home/${username}";
	};
};

}
