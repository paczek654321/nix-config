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
		nvidia =
		{
			modesetting.enable = true;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			open = false;
			nvidiaSettings = true;

			prime =
			{
				offload =
				{
					enable = true;
					enableOffloadCmd = true;
				};
				intelBusId = "PCI:0:2:0";
				nvidiaBusId = "PCI:1:0:0";
			};
		};
		enableRedistributableFirmware = true;
		cpu.intel.updateMicrocode = true;
	};

	services.xserver.videoDrivers = [ "modesetting" "nvidia"];

	boot.kernelPackages = pkgs.linuxPackages_latest;
	
	my.brave.enable = true;
	my.vesktop.enable = true;
	my.godot.enable = true;
	my.ssh.enable = true;
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

		unityhub
		dotnet-sdk
		python3

		cryptsetup
		steam-run
		openssl

		nerd-fonts.symbols-only
	];

	my.hyprland =
	{
		workspaces =
		{
			monitors = [ "eDP-1" ];
			workspaceSwitchPrefix = "";
		};
		
		settings.monitor = [ "eDP-1, highrr, auto, 1" ];
	};

	my.platform-theme =
	{
		font_size = 11;
		default_font = "Adwaita Sans";
		monospace_font = "Adwaita Mono";
		font_pkg = pkgs.adwaita-fonts;
		icon_theme = "Sours-Full-Color";
		icon_theme_pkg = pkgs.sours-full-color;
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
	
	my.backups =
	{
		enable = true;
		files =
		[
			{
				source = "/data/appdata/UnityEditor";
				destination = "/home/paczek/Unity/Hub/Editor";
			}
		];
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
