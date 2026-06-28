{ config, lib, pkgs, ... }:
{

config = lib.mkIf config.my.hyprland-de.enable
{
	xdg.portal =
	{
		enable = true;
		xdgOpenUsePortal = true;
		config =
		{
			Hyprland =
			{
				default =
				[
					"hyprland"
					"kde"
					"gtk"
				];
				"org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
			};
			common =
			{
				default = [ "kde" ];
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