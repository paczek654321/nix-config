{ config, lib, pkgs, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{
	system.stateVersion = "25.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

	boot =
	{
		loader =
		{
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
	};

	fileSystems =
	{
		"/" =
		{
			device = "/dev/disk/by-label/root";
			fsType = "ext4";
		};

		"/boot" =
		{
			device = "/dev/disk/by-label/EFI";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};

		"/data" =
		{
			device = "/dev/disk/by-label/data";
			fsType = "btrfs";
		};
	};

	time.timeZone = "Europe/Warsaw";

	my.locale =
	{
		enable = true;
		defaultLocale = "en_US.UTF-8";
		dataLocale = "pl_PL.UTF-8";
		keymap = "pl";
		consoleKeymap = "pl2";
	};

	my.user =
	{
		enable = true;
		username = "paczek";

		packages = with pkgs;
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
			soundux

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
	};

	my.vsftpd.enable = true;

	my.bash =
	{
		enable = true;
		prompt =
		{
			enable = true;
			plaques =
			[
				{
					command = "date +\"%H:%M\"";
					textColorCode = colorPalette.ansiiText;
					bgColorCode = colorPalette.ansiiPrimary;
				}
				{
					command = "whoami";
					textColorCode = colorPalette.ansiiText;
					bgColorCode = colorPalette.ansiiSecondary;
				}
				{
					command = "hostname";
					textColorCode = colorPalette.ansiiText;
					bgColorCode = colorPalette.ansiiPrimary;
				}
				{
					command = ''pwd | sed "s/^\/home\/$(whoami)/~/"'';
					textColorCode = "0";
					bgColorCode = "15";
				}
				{
					condition = "git status &> /dev/null";
					command = ''echo "$(git branch --show-current)$([ -n "$(git status -s)" ] && echo '*')"'';
					textColorCode = colorPalette.ansiiSecondary;
					bgColorCode = colorPalette.ansiiTertiary;
				}
			];
		};
		settings.shellAliases.pass = "/data/pass.sh";
	};

	my.git =
	{
		enable = true;
		settings =
		{
			core.editor = "nano";
			init.defaultbranch = "main";
			push.autoSetupRemote = "true";
			user =
			{
				name = "paczek654321";
				email = "paczek1024@proton.me";
			};
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
		};
	};

	my.brave.enable = true;
	my.vesktop.enable = true;
	my.godot.enable = true;
	my.ssh.enable = true;
	my.fastfetch.enable = true;
	my.kde-partition-manager.enable = true;
	my.kitty.enable = true;
	my.easyeffects.enable = true;
	my.dolphin.enable = true;
	my.r2modman.enable = true;
	my.piper-git.enable = true;

	my.hyprland =
	{
		enable = true;
		settings.bind = [ "$mainMod, 2, exec, ${lib.getExe pkgs.kitty}" ];
	};
	

	my.platform-theme = lib.mkDefault
	{
		enable = true;
		font_size = 11;
		default_font = "Adwaita Sans";
		monospace_font = "Adwaita Mono";
		font_pkg = pkgs.adwaita-fonts;
		qt_colorscheme_path = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
		cursor_name = "breeze_cursors";
		cursor_pkg = pkgs.kdePackages.breeze;
	};

	my.noctalia.enable = true;
	my.wl-clip-persist.enable = true;
	services.displayManager.ly.enable = true;

	home-manager.backupFileExtension = "hm-backup";
	home-manager.overwriteBackup = true;
}