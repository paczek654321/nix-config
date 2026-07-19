{ config, lib, pkgs, ...}:
{

options.my.godot.enable = lib.mkEnableOption "Enable Godot";

config = lib.mkIf config.my.godot.enable
{
	home-manager.users."${config.my.user.username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
	in
	{
		home.packages = [ pkgs.godotPackages_4_5.godot ];
		home.file.".local/share/godot".source = mkOutOfStoreSymlink "/data/appdata/Godot/share";
		home.file.".config/godot".source = mkOutOfStoreSymlink "/data/appdata/Godot/config";
	};
};

}