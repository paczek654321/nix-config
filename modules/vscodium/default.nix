{ config, lib, ... }:
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
		default = true;
		description = "VSCodium json configuration";
	};
};

config = lib.mkIf config.my.vscodium.enable
{
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