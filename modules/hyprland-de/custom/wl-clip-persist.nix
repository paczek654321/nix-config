{ config, lib, ... }:
{
	config = lib.mkIf config.my.hyprland-de.enable
	{
		home-manager.users."${config.my.user.username}".services.wl-clip-persist.enable = true;
	};
}
