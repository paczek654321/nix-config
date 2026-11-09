{ config, lib, pkgs, ...}:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{

options.my.fastfetch.enable = lib.mkEnableOption "Enable fastfetch";

config = lib.mkIf config.my.fastfetch.enable
{
	home-manager.users."${config.my.user.username}".programs.fastfetch =
	{
		enable = true;
		settings =
		{
			"$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
			logo.color = builtins.listToAttrs
			(
				builtins.genList (i:
				{
					name = toString (i + 1);
					value = (if (pkgs.lib.trivial.mod (i + 1) 2 == 0) then "@${colorPalette.ansiiPrimary}" else "@${colorPalette.ansiiSecondary}");
				}) 9
			);
			display =
			{
				separator = " : ";
			};
			modules =
			[
				{
					type = "colors";
					paddingLeft = 15;
					symbol = "diamond";
				}
				{
					type = "custom";
					format = "┌──────────────────────────────────────────┐";
				}
				{
					type = "title";
					key = "  ";
					format = "{6} {7} {8}";
					keyColor = "@${colorPalette.ansiiPrimary}";
					color =
					{
						user = "@${colorPalette.ansiiText}";
						at = "@${colorPalette.ansiiText}";
						host = "@${colorPalette.ansiiText}";
					};
				}
				{
					type = "os";
					key = "  󰣇 OS";
					format = "{2}";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "kernel";
					key = "   Kernel";
					format = "{2}";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "command";
					key = "  󱦟 OS Age";
					keyColor = "@${colorPalette.ansiiTertiary}";
					text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
				}
				{
					type = "uptime";
					key = "  󱫐 Uptime";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "packages";
					key = "  󰏗 Packages";
					keyColor = "@${colorPalette.ansiiPrimary}";
				}
				{
					type = "display";
					key = "  󰍹 Display";
					format = "{1}x{2} @ {3}Hz [{7}]";
					keyColor = "@${colorPalette.ansiiPrimary}";
				}
				{
					type = "terminal";
					key = "   Terminal";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "de";
					key = "   DE";
					format = "{2}";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "wm";
					key = "   WM";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "wmtheme";
					key = "   WM Theme";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "theme";
					key = "   Theme";
					format = "{2}";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "icons";
					key = "   Icons";
					format = "{2}";
					keyColor = "@${colorPalette.ansiiTertiary}";
				}
				{
					type = "cpu";
					format = "{1} @ {7}";
					key = "   CPU";
					keyColor = "@${colorPalette.ansiiPrimary}";
				}
				{
					type = "gpu";
					format = "{1} {2}";
					key = "  󰊴 GPU";
					keyColor = "@${colorPalette.ansiiPrimary}";
				}
				{
					type = "memory";
					key = "   Memory";
					keyColor = "@${colorPalette.ansiiPrimary}";
				}
				{
					type = "custom";
					format = "└──────────────────────────────────────────┘";
				}
				{
					type = "colors";
					paddingLeft = 15;
					symbol = "diamond";
				}
				"break"
			];
		};
	};
};

}