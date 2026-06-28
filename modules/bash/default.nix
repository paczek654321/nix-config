{ lib, config, ... }:
let
	username = config.my.user.username;
in
{
	imports =
	[
		./prompt.nix

		(lib.mkAliasOptionModule [ "my" "bash" "settings" ] [ "home-manager" "users" username "programs" "bash" ] )
	];
	options.my.bash.enable = lib.mkEnableOption "Enable BASH";

	config = lib.mkIf config.my.bash.enable
	{
		home-manager.users."${username}" =
		{
			programs.bash =
			{
				enable = true;
				enableCompletion = true;

				historyFile = "/data/.bash_history";
				historyControl = [ "erasedups" ];

				initExtra = builtins.concatStringsSep "\n"
				[
					''[[ "$TERM_PROGRAM" == "vscode" ]] && alias fastfetch="fastfetch --logo none"''
					"echo"
					"fastfetch"
				];

				shellAliases =
				{
					fucking = "sudo";
					
					ls = "ls --color=auto";
					grep = "grep --color=auto";
					
					rebuild = "sudo nixos-rebuild switch --flake /data/.nixos#$(hostname)";
					cleanup = "sudo nix-collect-garbage -d; nix store optimise";
					update = "nix flake update --flake /data/.nixos";
				};
			};
		};
	};
}