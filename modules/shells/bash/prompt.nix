{ lib, config, ... }:
let
	plaqueSeparator = config.my.bash.prompt.plaqueSeparator;

	bold = "\\[\\e[1m\\]";
	back = "\\[\\e[1D\\]";
	reset = "\\[\\e[0m\\]";

	color = code:
	{
		text = "\\[\\e[38;5;" + code + "m\\]";
		bg = "\\[\\e[48;5;" + code + "m\\]";
	};

	plaqueText = first: { condition ? "", command, textColorCode, bgColorCode}:
	let
		textColor = color textColorCode;
		bgColor = color bgColorCode;

		conditionText =
			if condition != ""
			then "${condition} && "
			else "";
		prefix =
			if !first
			then "${bgColor.bg}${plaqueSeparator}${reset}"
			else "";
		plaque =
			"${textColor.text}${bgColor.bg}${bold}"
			+ " $(${command}) "
			+ "${reset}${bgColor.text}";
	in
	"${conditionText}PS1+=\"${prefix}${plaque}\"";
	

	preparePlaques = plaques: builtins.concatStringsSep "\n" (lib.lists.imap0 (i: v: plaqueText (i == 0) v) plaques);
in
{

options.my.bash.prompt =
{
	enable = lib.mkEnableOption "Enable prompt customization";
	plaqueSeparator = lib.mkOption
	{
		type = lib.types.str;
		default = "";
		example = "";
		description = "The character that seperates plaques from each other.";
	};
	plaques = lib.mkOption
	{
		type = lib.types.listOf (lib.types.attrsOf lib.types.str);
		default = [];
		example =
		[{
			condition = "[ \"$(pwd)\" = \"$HOME\" ]";
			command = "hostname";
			textColorCode = "15";
			bgColorCode = "165";
		}];
		description = "Plaques that the promp is composed of.";
	};
};

config = lib.mkIf config.my.bash.prompt.enable
{
	home-manager.users."${config.my.user.username}" =
	{
		programs.bash.initExtra =
		''
			build_prompt()
			{
				PS1="\n"
				${preparePlaques config.my.bash.prompt.plaques}
				PS1+="${plaqueSeparator}${reset} "
			}
			PROMPT_COMMAND="build_prompt";
		'';
	};
};

}