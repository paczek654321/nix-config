{ config, lib, ... }:
{

config = lib.mkIf config.my.fcitx5-mandarin.enable
{	
	home-manager.users.${config.my.user.username}=
	{
		i18n.inputMethod.fcitx5.settings.addons.classicui.globalSection =
		{
			Theme = "noctalia";
			DarkTheme = "noctalia";
		};

		programs.noctalia.settings.theme.templates.community_ids = [ "fcitx5" ];
	};
};

}