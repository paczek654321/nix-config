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

		piper-git = prev.piper.overrideAttrs (old:
		{
			src = prev.fetchFromGitHub
			{
				owner = "libratbag";
				repo = "piper";
				rev = "master";
				hash = "sha256-0Rt/ere8kd3vYgouTPJwLy1D4VwEukDCiaR0wxOMhKk=";
			};
		});
		
		libratbag-git = prev.libratbag.overrideAttrs (old:
		{
			src = prev.fetchFromGitHub
			{
				owner = "libratbag";
				repo = "libratbag";
				rev = "master";
				hash = "sha256-c4nAVhI3m9VeGy+rZLPS8Z98RS9JbrHe/mdiuee5y4s=";
			};
		});

		cool-dark-icons = final.callPackage ./cool-dark-icons.nix {};
		sours-full-color = final.callPackage ./sours-full-color.nix {};
		beauty-solar = final.callPackage ./beauty-solar.nix {};
		soundux = final.callPackage ./soundux.nix {};
		godot = final.callPackage ./godot.nix {};
	})
];

}