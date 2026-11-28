{ config, lib, pkgs, ... }:
let
	keymap = config.my.locale.keymap;
in
{

options.my.fcitx5-mandarin.enable = lib.mkEnableOption "Enable fcitx5-mandarin";

config = lib.mkIf config.my.fcitx5-mandarin.enable
{
	home-manager.users.${config.my.user.username}=
	{
		i18n.inputMethod =
		{
			enable = true;
			type = "fcitx5";

			fcitx5 =
			{
				waylandFrontend = true;

				addons = with pkgs;
				[
					fcitx5-gtk
					qt6Packages.fcitx5-qt
					qt6Packages.fcitx5-chinese-addons
				];

				settings =
				{
					globalOptions."Hotkey/EnumerateGroupForwardKeys" = { "#0" = "Super+space"; };

					addons =
					{
						pinyin.globalSection =
						{
							CloudPinyinEnabled = false;
							FirstRun = false;
						};
					};

					inputMethod =
					{
						GroupOrder."0" = "Default";

						"Groups/0" =
						{
							Name = "Default";
							"Default Layout" = keymap;
							DefaultIM = "keyboard-${keymap}";
						};

						"Groups/0/Items/0".Name = "keyboard-${keymap}";
						"Groups/0/Items/1".Name = "pinyin";
					};
				};
			};
		};
	};
};

}