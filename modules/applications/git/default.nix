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
		my.symlinks =
		[
			{
				source = "/data/.git-credentials";
				destination = ".git-credentials";
			}
		];
		
		home-manager.users."${username}".programs.git =
		{
			enable = true;
			settings.credential.helper = "store";
		};
		
		my.gpg.enable = true;
	};
}