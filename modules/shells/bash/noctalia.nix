{ lib, config, pkgs, ... }:
let
	toANSI = color: "{{ ${color}.red }};{{ ${color}.green }};{{ ${color}.blue }}";
	template = pkgs.writeText ".bash_colors"
	''
		color_primary="${toANSI "colors.primary.default"}"
		color_on_primary="${toANSI "colors.on_primary.default"}"

		color_secondary="${toANSI "colors.secondary.default"}"
		color_on_secondary="${toANSI "colors.on_secondary.default"}"

		color_tertiary="${toANSI "colors.tertiary.default"}"
		color_on_tertiary="${toANSI "colors.on_tertiary.default"}"
	'';
in
{
	config = lib.mkIf config.my.bash.enable
	{
		home-manager.users.${config.my.user.username}.programs =
		{
			bash.initExtra = "source ~/.bash_colors";
			noctalia.settings.theme.templates.user.bash =
			{
				input_path= template;
				output_path = "~/.bash_colors";
			};
		};
	};
}