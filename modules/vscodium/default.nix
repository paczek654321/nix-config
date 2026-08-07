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
	home-manager.users."${username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
	in
	{
		programs.vscodium.enable = true;
		home.file.".vscode-oss/extensions".source = mkOutOfStoreSymlink "/data/appdata/vsc-extensions";
		home.file.".config/VSCodium/User/settings.json".text = builtins.toJSON config.my.vscodium.settings;
	};
};

}