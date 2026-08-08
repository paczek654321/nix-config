{lib, config, pkgs, inputs, ...}:
let
	enginePath = config.my.unreal-engine.enginePath;
	runUnreal = inputs.unreal.packages.${pkgs.stdenv.hostPlatform.system}.run-unreal;
	unrealFHS = inputs.unreal.packages.${pkgs.stdenv.hostPlatform.system}.default;
	
	executable = pkgs.writeShellScriptBin "unreal-editor"
	''
		UE_PATH="${enginePath}" "${runUnreal}/bin/run-unreal"
	'';

	desktopItem = pkgs.makeDesktopItem
	{
		name = "unreal-editor";
		desktopName = "Unreal Engine";
		exec = "${executable}/bin/unreal-editor";
		icon = "${enginePath}/Engine/Content/Editor/Slate/About/UnrealLogo.svg";
		categories = [ "Development" ];
	};
in
{

imports = [ ./rider.nix ];

options.my.unreal-engine =
{
	enable = lib.mkEnableOption "Enable Unreal Engine";
	enginePath = lib.mkOption
	{
		type = lib.types.str;
		description = "Unreal Engine root path";
	};
};

config = lib.mkIf config.my.unreal-engine.enable
{
	_module.args = { inherit unrealFHS; };

	environment.systemPackages =
	[
		executable
		desktopItem
		unrealFHS
	];
};

}
