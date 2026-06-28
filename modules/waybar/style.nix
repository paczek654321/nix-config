{ config, lib, pkgs, ... }:
let
	colorPalette = config.my.platform-theme.colorPalette;
in
{

config = lib.mkIf config.my.waybar.enable
{
	home-manager.users."${config.my.user.username}".programs.waybar.style =
	''
		@define-color accent #${colorPalette.primaryAccent};
		@define-color bg #${colorPalette.background};

		*
		{
			color: @accent;
		}
		#workspaces button
		{
			font-size: 15;
		}
		#workspaces button.visible
		{
			font-size: 25;
		}
		#keyboard-state label
		{
			font-size: 20;
		}
		window#waybar
		{
			background: @bg;
			border-bottom: 3 solid @accent;
			border-radius: 15;
		}
		.modules-right .module
		{
			background-color: @bg;
			padding: 0 8 0 8;
			border: @accent solid 1;
			border-radius: 20;
			margin-bottom: 5;
			margin-top: 2;
		}
		.modules-right
		{
			margin-right: 10
		}
		.modules-left
		{
			margin-left: 15;
		}
	'';
};

}
