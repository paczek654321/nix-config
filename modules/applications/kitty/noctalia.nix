{ config, lib, ...}:
{
config = lib.mkIf config.my.kitty.enable
{
	home-manager.users."${config.my.user.username}".programs =
	{
		kitty.settings.include = "themes/noctalia.conf";
		noctalia.settings.theme.templates.builtin_ids = [ "kitty" ];
	};
};

}