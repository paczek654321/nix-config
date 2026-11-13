{ config, lib, pkgs, ... }:
{

config =
{
	xdg.portal =
	{
		enable = true;
		xdgOpenUsePortal = true;
		config =
		{
			umbriel =
			{
				default =
				[
					"umbriel"
					"kde"
					"gtk"
				];
				"org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
			};
		};
		extraPortals = with pkgs;
		[
			kdePackages.xdg-desktop-portal-kde
			xdg-desktop-portal-gtk
		];
	};
};

}