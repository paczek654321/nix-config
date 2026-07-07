{ config, lib, inputs, ... }:
let
	cfg = config.my.noctalia;
	username = config.my.user.username;
in
{

imports = [ ./hyprland.nix ];

options.my.noctalia =
{
	enable = lib.mkEnableOption "Enable Noctalia";
	settingsFile = lib.mkOption
	{
		type = lib.types.nullOr lib.types.str;
		default = "/data/.nixos/modules/noctalia/settings.json";
		description = "Path to the out of store config file. Set to null in order to disable imperative configuration.";
	};
};

config = lib.mkIf config.my.noctalia.enable
{
	networking.networkmanager.enable = true;
	services.power-profiles-daemon.enable = true;
	services.upower.enable = true;

	my.bluetooth =
	{
		enable = true;
		withBlueman = false;
	};

	my.hyprland.settings.exec-once = lib.mkIf config.my.hyprland.enable ["noctalia-shell"];

	home-manager.users."${username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
	in
	{
		imports =
		[
			inputs.noctalia.homeModules.default
		];

		programs.noctalia-shell.enable = true;
		# Allow imperative configuration while still tracking the config in the flake git repo
		home.file.".config/noctalia/settings.json".source = lib.mkIf (cfg.settingsFile != null) (mkOutOfStoreSymlink cfg.settingsFile);
	};

	my.platform-theme = lib.mkIf config.my.platform-theme.enable
	{
		qt_colorscheme_path = "/home/${username}/.local/share/color-schemes/noctalia.colors";
	};
	my.vscodium.settings.workbench.colorTheme = lib.mkIf config.my.vscodium.enable "NoctaliaTheme";
};

}