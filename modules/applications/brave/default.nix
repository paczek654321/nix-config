{lib, config, pkgs, ...}:
let
	username = config.my.user.username;
in
{

options.my.brave.enable = lib.mkEnableOption "Enable Brave browser";

config = lib.mkIf config.my.brave.enable
{
	environment.systemPackages = with pkgs; [ brave ];
	home-manager.users."${username}" = hm:
	let
		mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
	in
	{
		home.file.".config/BraveSoftware/Brave-Browser".source = mkOutOfStoreSymlink "/data/appdata/Brave";
	};
};

}
