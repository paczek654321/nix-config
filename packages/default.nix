{ pkgs, pkgsOld, inputs, ... }:
{

nixpkgs.overlays = 
[
	(final: prev: 
	{
		krita = pkgsOld.krita;
		
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
				rev = "452f46ce861948cacdf0f7948964e67a29d027b9";
				hash = "sha256-0PLf8YZmEV1SQcEMEa0fm9GZkrD8jvtNG+iIeqRkJJw=";
			};
		});
		
		libratbag-git = prev.libratbag.overrideAttrs (old:
		{
			src = prev.fetchFromGitHub
			{
				owner = "libratbag";
				repo = "libratbag";
				rev = "03afbe49f30a4fd18d830530685804eb3bd57c39";
				hash = "sha256-vlo3RfpLJQTw7P5Bmopl8vi4nDrY9OwNM6tVja+scq8=";
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