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
	my.symlinks =
	[
		{
			source = "/data/appdata/Godot/share";
			destination = ".local/share/godot";
		}
		{
			source = "/data/appdata/Godot/config";
			destination = ".config/godot";
		}
	];

	environment.systemPackages =
	let
		devPackages = if config.my.godot.enableDevPackages then (with pkgs;
		[
			clang-tools
			clang
			scons
			pkg-config
			emscripten
		]) else [];
	in
		with pkgs; [ pkgs.godotPackages_4_5.godot ] ++ devPackages;
};

}