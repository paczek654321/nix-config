{

description = "Nixos config flake";

inputs =
{
	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	firmware-downgrade.url = "github:NixOS/nixpkgs/78173555c5d16bee8ab97ce9ef1d257d5657b442";

	home-manager =
	{
		 url = "github:nix-community/home-manager";
		 inputs.nixpkgs.follows = "nixpkgs";
	};

	ilya-fedin = {
    	url = "github:ilya-fedin/nur-repository";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
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
};

}
