{

description = "Nixos config flake";

inputs =
{
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	nixpkgs-old.url = "github:NixOS/nixpkgs/78173555c5d16bee8ab97ce9ef1d257d5657b442";
	nixpkgs-git.url = "github:nixos/nixpkgs/master";

	home-manager =
	{
		 url = "github:nix-community/home-manager";
		 inputs.nixpkgs.follows = "nixpkgs";
	};

	ilya-fedin =
	{
    	url = "github:ilya-fedin/nur-repository";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

	noctalia =
	{
    	url = "github:noctalia-dev/noctalia/legacy-v4";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

	millennium =
	{
    	url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
};

nixConfig =
{
	extra-substituters = [ "https://noctalia.cachix.org" ];
	extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
};

outputs = { self, nixpkgs, ... }@inputs:
let
	system = "x86_64-linux";
	pkgsOld = import inputs.nixpkgs-old
	{
		inherit system;
		config.allowUnfree = true;
  	};
	pkgsGit = import inputs.nixpkgs-git
	{
		inherit system;
		config.allowUnfree = true;
  	};
	specialArgs = { inherit inputs pkgsOld pkgsGit; };
in
{
	nixosConfigurations.Hephaestus = nixpkgs.lib.nixosSystem
	{
		inherit system specialArgs;
		modules =
		[
			./packages
			./modules
			./hosts/Hephaestus.nix
		];
	};
	nixosConfigurations.Loviatar = nixpkgs.lib.nixosSystem
	{
		inherit system specialArgs;
		modules =
		[
			./packages
			./modules
			./hosts/Loviatar.nix
		];
	};
};

}
