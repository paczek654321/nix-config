{ config, lib, ... }:
let
	withBlueman = config.my.bluetooth.withBlueman;
in 
{
	options.my.bluetooth =
	{
		enable = lib.mkEnableOption "Enable Bluetooth";
		withBlueman = lib.mkOption
		{
			type = lib.types.bool;
			default = true;
			description = "Enable Blueman GUI and applet";
		};
	};

	config = lib.mkIf config.my.bluetooth.enable
	{
		hardware.bluetooth =
		{
			enable = true;
			powerOnBoot = true;
			settings =
			{
				General.Experimental = true;
				Policy.AutoEnable = true;
			};
		};

		services.blueman = lib.mkIf withBlueman
		{
			enable = true;
		};
		home-manager.users."${config.my.user.username}".services.blueman-applet.enable = lib.mkIf withBlueman true;
	};
}