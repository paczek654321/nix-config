{

description = "Nixos config flake";

inputs =
{
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	hephaestus-firmware.url = "github:NixOS/nixpkgs/78173555c5d16bee8ab97ce9ef1d257d5657b442";

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
};

nixConfig =
{
	extra-substituters = [ "https://noctalia.cachix.org" ];
	extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
};

outputs = { self, nixpkgs, ... }@inputs:
{
	nixosConfigurations.Hephaestus = nixpkgs.lib.nixosSystem
	{
		system = "x86_64-linux";
		specialArgs = {inherit inputs; };
		modules =
		[
			./packages
			./modules
			./hosts/Hephaestus.nix
		];
	};
	nixosConfigurations.Loviatar = nixpkgs.lib.nixosSystem
	{
		system = "x86_64-linux";
		specialArgs = {inherit inputs; };
		modules =
		[
			./packages
			./modules
			./hosts/Loviatar.nix
		];
	};
};

}
