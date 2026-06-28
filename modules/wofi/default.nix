{ config, lib, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{

options.my.wofi.enable = lib.mkEnableOption "Enable Wofi";

config = lib.mkIf config.my.wofi.enable
{
	home-manager.users."${config.my.user.username}".programs.wofi =
	{
		enable = true;
		settings =
		{
			insensitive = true;
			width = "30%";
			height = "33%";
			allow_images = true;
		};
		style =
		''
			*
			{
				background: none;
				color: #${colorPalette.primaryAccent};
				border-color: #${colorPalette.primaryAccent};
			}
			#window
			{
				border: 3 solid;
				padding: 10;
				background-color: #${colorPalette.background}40;
				border-radius: 15;
			}
			#window > *
			{
				padding: 3;
			}
			#entry:selected
			{
				background-image: linear-gradient(270deg, #${colorPalette.primaryAccent}, transparent);
			}
			#entry
			{
				padding: 5;
			}
		'';
	};
};

}
