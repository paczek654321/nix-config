{ config, lib, pkgs, ...}:
let
	hexOf = key: "{{ colors.${key}.default.hex }}";
	setColor = key: "{#${hexOf key}}";
	
	mkSeperator = r: l: borderColor+r+"═══════════════════════════════════════════════════════════════════════════"+l+builtins.fromJSON ''"\u001b[76D{#1}"'';
	card = builtins.fromJSON ''"${borderColor}║\u001b[75C║\u001b[75D{#0}"'';
	
	borderColor = setColor "secondary";

	template = pkgs.writeText "vesktop.css" (lib.toJSON
	{
		"$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
		logo.color = builtins.listToAttrs
		(
			builtins.genList (i:
			{
				name = toString (i + 1);
				value = (if (pkgs.lib.trivial.mod (i + 1) 2 == 0)
					then hexOf "primary"
					else hexOf "secondary");
			}) 9
		);
		display =
		{
			separator = " : ";
			color.separator = hexOf "primary";
		};
		modules =
		[
			{
				format = mkSeperator "╔" "╗";
				type = "custom";
			}
			{
				format = "${card}${setColor "primary"} {#1}{user-name}${setColor "secondary"}@${setColor "primary"}{host-name}";
				type = "title";
			}
			{
				format = "${mkSeperator "╠" "╣"}  Software ";
				type = "custom";
			}
			{
				key = "${card}${setColor "tertiary"} OS      ";
				type = "os";
			}
			{
				key = "${card}${setColor "tertiary"} Kernel  ";
				type = "kernel";
			}
			{
				key = "${card}${setColor "tertiary"} WM      ";
				type = "wm";
			}
			{
				format = "${mkSeperator "╠" "╣"} 󰅐 Time ";
				type = "custom";
			}
			{
				key = "${card}${setColor "primary"}󰸗 Date    ";
				type = "datetime";
				format = "{day-in-month} {month-name} {year}";
			}
			{
				key = "${card}${setColor "primary"}󰺗 Clock   ";
				type = "datetime";
				format = "{hour-pretty}:{minute-pretty} {timezone-name}";
			}
			{
				key = "${card}${setColor "primary"}󱦟 OS Age  ";
				type = "command";
				text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
			}
			{
				key = "${card}${setColor "primary"} Uptime  ";
				type = "uptime";
			}
			{
				format = "${mkSeperator "╠" "╣"} 󰒋 Hardware ";
				type = "custom";
			}
			{
				key = "${card}${setColor "tertiary"}󰍛 CPU     ";
				type = "cpu";
				showPeCoreCount = true;
			}
			{
				key = "${card}${setColor "tertiary"} GPU     ";
				type = "gpu";
			}
			{
				key = "${card}${setColor "tertiary"} RAM     ";
				type = "memory";
			}
			{
				key = "${card}${setColor "tertiary"}󰍹 Display ";
				type = "display";
				format = "{1}x{2} @ {3}Hz [{7}]";
			}
			{
				format = "${mkSeperator "╠" "╣"}  Network ";
				type = "custom";
			}
			{
				key = "${card}${setColor "primary"} Local IP";
				type = "localip";
				format = "{ipv4} ({ifname})";
			}
			{
				format = mkSeperator "╚" "╝";
				type = "custom";
			}
		];
	});
in
{
config = lib.mkIf config.my.fastfetch.enable
{
	home-manager.users."${config.my.user.username}".programs.noctalia.settings.theme.templates.user.fastfetch =
	{
		input_path= template;
		output_path = "~/.config/fastfetch/config.jsonc";
	};
};

}