{ config, lib, ... }:
let
	username = config.my.user.username;
	colorPalette = config.my.platform-theme.colorPalette;
in
{

imports =
[
	(lib.mkAliasOptionModule [ "my" "vesktop" "settings" ] [ "home-manager" "users" username "programs" "vesktop" "settings" ] )
	(lib.mkAliasOptionModule [ "my" "vesktop" "vencord" "settings" ] [ "home-manager" "users" username "programs" "vesktop" "vencord" "settings" ] )
];

options.my.vesktop.enable = lib.mkEnableOption "Enable Vesktop";

config = lib.mkIf config.my.vesktop.enable
{
	home-manager.users."${username}".programs.vesktop =
	{
		enable = true;
		settings =
		{
			discordBranch = "stable";
			minimizeToTray = true;
			spellCheckLanguages = [ "en-US" "en" "${config.my.locale.keymap}" ];
		};
		vencord =
		{
			settings =
			{
				autoUpdate = false;
				useQuickCss = true;
				frameless = true;
				transparent = true;
				
				plugins =
				{
					Dearrow =
					{
						enabled = true;
						hideButton = false;
						replaceElements = 0;
						dearrowByDefault = true;
					};
					FixImagesQuality =
					{
						enabled = true;
						originalImagesInChat = false;
					};
					RoleColorEverywhere =
					{
						enabled = true;
						chatMentions = true;
						memberList = true;
						voiceUsers = true;
						reactorsList = true;
						pollResults = true;
						colorChatMessages = false;
					};
					ShowHiddenChannels =
					{
						enabled = true;
						showMode = 0;
						hideUnreads = true;
						defaultAllowedUsersAndRolesDropdownState = true;
					};
					SpotifyCrack =
					{
						enabled = true;
						noSpotifyAutoPause = true;
						keepSpotifyActivityOnIdle = false;
					};
					Translate =
					{
						enabled = true;
						autoTranslate = false;
						showChatBarButton = true;
					};
					TypingIndicator =
					{
						enabled = true;
						includeMutedChannels = false;
						includeCurrentChannel = true;
						indicatorMode = 3;
					};
					VolumeBooster =
					{
						enabled = true;
						multiplier = 4;
					};
					WebScreenShareFixes =
					{
						enabled = true;
						experimentalAV1Support = false;
					};
					NoTrack =
					{
						enabled = true;
						disableAnalytics = true;
					};
					Settings =
					{
						enabled = true;
						settingsLocation = "aboveNitro";
					};
					ChatInputButtonAPI.enabled = true;
					CommandsAPI.enabled = true;
					MessageAccessoriesAPI.enabled = true;
					MessageEventsAPI.enabled = true;
					MessagePopoverAPI.enabled = true;
					UserSettingsAPI.enabled = true;
					CrashHandler.enabled = true;
					ForceOwnerCrown.enabled = true;
					NoF1.enabled = true;
					PreviewMessage.enabled = true;
					ReverseImageSearch.enabled = true;
					WebKeybinds.enabled = true;
					YoutubeAdblock.enabled = true;
					BadgeAPI.enabled = true;
					DisableDeepLinks.enabled = true;
					SupportHelper.enabled = true;
					WebContextMenus.enabled = true;
					ConcatenatedComponentExtractor.enabled = true;
				};
			};
			extraQuickCss =
			''
				/*Transparent by default*/
				*
				{
				background-color: #FFFFFF00 !important;
				backdrop-filter: none !important;
				}
				/*Main bg*/
				html
				{
					background: #${colorPalette.background}80!important;
				}
				/*All popup menus*/
				[role="dialog"] > * > *
				{
				background: #${colorPalette.background}80!important;
				backdrop-filter: blur(10px) !important;
				}
				/*Hover popups*/
				[class*="tooltip"], [class*="Tool"], [role="menu"]
				{
				background: #FFFFFF00 !important;
				backdrop-filter: blur(10px) !important;
				}
				/*Server notif icon*/
				[aria-label="Servers"] [class*="item_"]
				{
				background-color: white !important;
				}
			'';
		};
	};
};

}