{ pkgs, inputs, ... }:
{

nixpkgs.overlays = 
[
	(final: prev: 
	{
		
		qt6Packages = prev.qt6Packages //
		{
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

		godotPackages_4_5 = prev.godotPackages_4_5 //
		{
			godot = prev.godotPackages_4_5.godot.overrideAttrs (old:
			{
				src = prev.fetchFromGitHub
				{
					owner = "paczek654321";
					repo = "godot";
					rev = "9eac3aebce158d1d745064fa858e652d4d5ebad6";
					hash = "sha256-nvvGi7Ukny+l85h0v6fElpx0JgehCw/EIfsKansRFY0=";
				};
			});

			godot-mono = final.godotPackages_4_5.godot.override
			{
				withMono = true;
			};

			export-template = final.godotPackages_4_5.godot.export-template;
			export-template-mono = final.godotPackages_4_5.godot-mono.export-template;
		};

		cool-dark-icons = final.callPackage ./cool-dark-icons.nix {};
		sours-full-color = final.callPackage ./sours-full-color.nix {};
		beauty-solar = final.callPackage ./beauty-solar.nix {};
		soundux = final.callPackage ./soundux.nix {};
	})
];

}