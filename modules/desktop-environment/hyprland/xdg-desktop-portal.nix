{ config, lib, pkgs, ... }:
{

config = lib.mkIf config.my.hyprland.enable
{
	xdg.portal =
	{
		enable = true;
		xdgOpenUsePortal = true;
		config =
		{
			hyprland =
			{
				default =
				[
					"hyprland"
					"kde"
					"gtk"
				];
				"org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
			};
		};
		extraPortals = with pkgs;
		[
			kdePackages.xdg-desktop-portal-kde
			xdg-desktop-portal-hyprland
			xdg-desktop-portal-gtk
		];
	};
};

}