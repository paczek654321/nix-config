{ config, lib, ... }:
{

config = lib.mkIf config.my.hyprland.enable
{
	home-manager.users."${config.my.user.username}".services.hyprpaper =
	{
		enable = true;
		settings =
		{
			splash = false;
			wallpaper =
			{
				monitor = "";
				path = "/data/wallpaper.png";
				fit_mode = "cover";
			};
		};
	};
};

}
