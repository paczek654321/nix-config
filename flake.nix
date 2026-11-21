{

description = "Nixos config flake";

inputs =
{
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	nixpkgs-git.url = "github:nixos/nixpkgs/master";

	import-tree.url = "github:denful/import-tree";

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

	umbriel =
	{
    	url = "github:noctalia-dev/umbriel";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

	umbriel-accent-gradient =
	{
		url = "github:paczek654321/umbriel-accent-gradient";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	noctalia =
	{
    	url = "github:noctalia-dev/noctalia";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

	millennium =
	{
    	url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

	unreal =
	{
		url = "github:paczek654321/NixOSUnreal";
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
	pkgsGit = import inputs.nixpkgs-git
	{
		inherit system;
		config.allowUnfree = true;
  	};
	specialArgs = { inherit self inputs pkgsGit; };
in
{
	nixosConfigurations.Hephaestus = nixpkgs.lib.nixosSystem
	{
		inherit system specialArgs;
		modules =
		[
			(inputs.import-tree ./modules)
			./hosts/Hephaestus.nix
		];
	};
	nixosConfigurations.Loviatar = nixpkgs.lib.nixosSystem
	{
		inherit system specialArgs;
		modules =
		[
			(inputs.import-tree ./modules)
			./hosts/Loviatar.nix
		];
	};
};

}
