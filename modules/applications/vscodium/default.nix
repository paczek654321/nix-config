{ config, lib, pkgs, ... }:
let
	username = config.my.user.username;
in
{

options.my.vscodium =
{
	enable = lib.mkEnableOption "Enable VSCodium";
	settings = lib.mkOption
	{
		type = lib.types.attrs;
		description = "VSCodium json configuration";
	};
	launchWithCode = lib.mkOption
	{
		type = lib.types.bool;
		default = true;
		description = "Allow launching with the code command";
	};
};

config = lib.mkIf config.my.vscodium.enable
{
	environment.systemPackages = lib.mkIf config.my.vscodium.launchWithCode
	[
		(pkgs.writeShellScriptBin "code" ''exec codium "$@"'')
	];

	my.symlinks =
	[
		{
			source = "/data/appdata/vsc-extensions";
			destination = ".vscode-oss/extensions";
		}
	];

	home-manager.users."${username}" =
	{
		programs.vscodium.enable = true;
		home.file.".config/VSCodium/User/settings.json".text = builtins.toJSON config.my.vscodium.settings;
	};
};

}