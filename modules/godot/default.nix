{ config, lib, pkgs, ...}:
{

options.my.godot =
{
	enable = lib.mkEnableOption "Enable Godot";
	enableDevPackages = lib.mkOption
	{
		type = lib.types.bool;
		default = true;
		description = "Install packages necessary for modifying Godot source";
	};
};

config = lib.mkIf config.my.godot.enable
{
	home-manager.users."${config.my.user.username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
		devPackages = if config.my.godot.enableDevPackages then (with pkgs;
		[
			clang-tools
    		clang
			scons
			pkg-config
			emscripten
		]) else [];
	in
	{
		home.packages = [ pkgs.godotPackages_4_5.godot ] ++ devPackages;
		home.file.".local/share/godot".source = mkOutOfStoreSymlink "/data/appdata/Godot/share";
		home.file.".config/godot".source = mkOutOfStoreSymlink "/data/appdata/Godot/config";
	};
};

}