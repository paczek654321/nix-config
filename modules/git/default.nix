{ lib, config, pkgs, ... }:
let
	username = config.my.user.username;
in
{
	imports =
	[
		(lib.mkAliasOptionModule [ "my" "git" "settings" ] [ "home-manager" "users" username "programs" "git" "settings" ] )
	];

	options.my.git.enable = lib.mkEnableOption "Enable Git";

	config = lib.mkIf config.my.git.enable
	{
		home-manager.users."${username}" = hm:
		let
			mkOutOfStoreSymlink = hm.config.lib.file.mkOutOfStoreSymlink;
		in
		{

			home.file =
			{
				".git-credentials".source = mkOutOfStoreSymlink "/data/.git-credentials";
			};
			programs.git =
			{
				enable = true;
				settings.credential.helper = "store";
			};
		};
	};
}