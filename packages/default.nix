{ pkgs, inputs, ... }:
{

nixpkgs.overlays = 
[
	(final: prev: 
	{
		
		qt6Packages = prev.qt6Packages // {
			qt6ct = inputs.ilya-fedin.packages.${prev.stdenv.hostPlatform.system}.qt6ct;
		};

		superfile = prev.superfile.overrideAttrs (old:
		{
			patches = (old.patches or []) ++
			[
				./superfile.patch
			];
		});

		cool-dark-icons = final.callPackage ./cool-dark-icons.nix {};
		soundux = final.callPackage ./soundux.nix {};
		godot = final.callPackage ./godot.nix {};
	})
];

}