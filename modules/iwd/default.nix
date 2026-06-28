{ config, lib, ...}:
{

options.my.iwd.enable = lib.mkEnableOption "Enable IWD";

config = lib.mkIf config.my.iwd.enable
{
	services.resolved.enable = true;
	networking.wireless.iwd =
	{
		enable = true;
		settings =
		{
			Network.NameResolvingService = "systemd";
			General.EnableNetworkConfiguration = true;
		};
	};
};

}