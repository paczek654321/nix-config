{ config, pkgs, lib, ... }:
{

config = lib.mkIf config.my.fcitx5-mandarin.enable
{
	my.umbriel.settings =
	{
		general.autostart = [ "fcitx5" ];
		keybinds."Mod+Tab" = "spawn fcitx5-remote -t";
	};

	home-manager.users.${config.my.user.username}.i18n.inputMethod.fcitx5 =
	{
		systemd.enable = false;
		fcitx5-with-addons = pkgs.qt6Packages.fcitx5-with-addons.overrideAttrs (old: 
		{
			buildCommand = (old.buildCommand or "") +
			''
				rm -f "$out/etc/xdg/autostart/org.fcitx.Fcitx5.desktop"
			'';
		});
	};
};

}