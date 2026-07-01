{ config, lib, pkgs, inputs, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{
	imports = [ ./common.nix ];

	networking.hostName = "Loviatar";

	hardware =
	{
		graphics =
		{
			enable = true;
			enable32Bit = true;
		};
		enableRedistributableFirmware = true;
		cpu.intel.updateMicrocode = true;
	};

	fileSystems =
	{
		"/" =
		{
			device = "/dev/disk/by-id/REDACTED-part2";
			fsType = "ext4";
		};

		"/boot" =
		{
			device = "/dev/disk/by-id/REDACTED-part1";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};

		"/data" =
		{
			device = "/dev/disk/by-id/REDACTED-part3";
			fsType = "btrfs";
		};
	};

	boot.kernelPackages = pkgs.linuxPackages_latest;

	my.ddcci =
	{
		enable = true;
		displayDev = "AMDGPU DM aux hw bus *";
	};
	
	my.brave.enable = true;
	my.vesktop.enable = true;
	my.fastfetch.enable = true;
	my.kde-partition-manager.enable = true;
	my.kitty.enable = true;
	my.easyeffects.enable = true;
	my.dolphin.enable = true;

	my.user.packages = with pkgs;
	[
		kdePackages.ark
		kdePackages.gwenview
		kdePackages.kate
		kdePackages.okular
		kdePackages.isoimagewriter
		kdePackages.filelight
		
		vlc
		xfburn
		libreoffice-fresh

		krita
		blender
		audacity
		lmms

		obs-studio
		obsidian
		spotify

		gamemode
		heroic
		steam

		cryptsetup
		steam-run
		openssl

		nerd-fonts.symbols-only
	];

	my.hyprland-de =
	{
		enable = true;
		workspaces =
		{
			monitors =
			[
				"eDP-1"
			];
			workspaceSwitchPrefix = "";
		};
		settings =
		{
			monitor =
			[
				"eDP-1, highrr, auto, 1"
			];
		};
	};

	my.platform-theme =
	{
		font_size = 11;
		default_font = "Adwaita Sans";
		monospace_font = "Adwaita Mono";
		font_pkg = pkgs.adwaita-fonts;
		icon_theme = "Cool-Dark-Icons";
		icon_theme_pkg = pkgs.cool-dark-icons;
		qt_colorscheme_path = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
		cursor_name = "breeze_cursors";
		cursor_pkg = pkgs.kdePackages.breeze;

		colorPalette =
		{
			ansiiPrimary = "118";
			ansiiSecondary = "226";
			ansiiTertiary = "28";
			ansiiText = "18";
			primaryAccent = "5AD950";
			secondaryAccent = "f5f844";
			background = "242424";
		};
	};

	my.vscodium =
	{
		enable = true;
		settings =
		{
			editor =
			{
				tabSize = 4;
				insertSpaces = false;
				detectIndentation = false;
			};
			"[nix]".editor = config.my.vscodium.settings.editor;
			workbench.colorTheme = "Sweet Dracula Monokai";
		};
	};
}
