{ config, lib, ... }:
let
	username = config.my.user.username;
in
{

config =
{
	home-manager.users.${username}.programs.noctalia.settings =
	{
		brightness =
		{
			enable_ddcutil = true;
			minimum_brightness = 0.01;
			sync_all_monitors = true;
		};

		shell.polkit_agent = true;
	};
};

}