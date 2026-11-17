{ config, lib, pkgs, ...}:
let
	background = "{{ colors.background.default.hex }}";
	template = pkgs.writeText "vesktop.css"
	''
		html
		{
			background: ${background}90 !important;
		}
		
		[role="dialog"]>*>[class*="container"], [role="menu"], [class*="tooltip"], [class*="Tool"]
		{
			background: ${background}C0 !important;
			backdrop-filter: blur(10px) !important;
		}

		[role="dialog"]
		{
			backdrop-filter: blur(10px) !important;
		}

		*
		{
			--background-surface-high: ${background}C0 !important;

			${builtins.concatStringsSep "\n"
			(
				map (n: "--neutral-${toString n}: #00000000 !important;") (builtins.genList (i: i + 50) 51)
			)}
		}
	'';
in
{
config = lib.mkIf config.my.vesktop.enable
{
	home-manager.users."${config.my.user.username}".programs.noctalia.settings.theme.templates.user.vesktop =
	{
		input_path  = template;
		output_path = "~/.config/vesktop/settings/quickCss.css";
	};
};

}