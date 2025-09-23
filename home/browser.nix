{
  lib,
  config,
  ...
}:

{
  catppuccin.librewolf.enable = false;

  stylix.targets.librewolf = {
    firefoxGnomeTheme.enable = true;
    profileNames = [ "default" ];
  };

  xdg.mimeApps.defaultApplicationPackages = [ config.programs.librewolf.package ];

  programs.librewolf = {
    enable = true;

    languagePacks = [
      "en-US"
      "pt-BR"
    ];

    settings = {
      "privacy.resistFingerprinting.letterboxing" = true;
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "middlemouse.paste" = false;
    };

    policies = {
      DisplayBookmarksToolbar = "newtab";
      Homepage.StartPage = "previous-session";
      NoDefaultBookmarks = true;
      OverrideFirstRunPage = "";
      ShowHomeButton = false;
      SkipTermsOfUse = true;
      TranslateEnabled = false;
      UserMessaging.SkipOnboarding = true;

      ExtensionSettings = {
        "*".installation_mode = "blocked";
      }
      // (lib.genAttrs
        [
          "uBlock0@raymondhill.net"
          "@contain-google"
          "istilldontcareaboutcookies"
          "sponsorBlocker@ajay.app"
          "{b86e4813-687a-43e6-ab65-0bde4ab75758}" # "localcdn-fork-of-decentraleyes"
          "{9350bc42-47fb-4598-ae0f-825e3dd9ceba}" # absolute-enable-right-click
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" # bitwarden-password-manager
          "{74145f27-f039-47ce-a470-a662b129930a}" # clearurls
          "{6def1df3-6313-4648-a6ca-945b92aba510}" # no-google-search-translation
        ]
        (id: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
          default_area = "menupanel";
          installation_mode = "force_installed";
          private_browsing = true;
        })
      );

      "3rdparty".Extensions."uBlock0@raymondhill.net" = {
        toOverwrite = {
          filterLists = [
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-unbreak"
            "ublock-quick-fixes"
            "adguard-generic"
            "adguard-mobile"
            "easylist"
            "adguard-spyware-url"
            "block-lan"
            "easyprivacy"
            "urlhaus-1"
            "curben-phishing"
            "adguard-cookies"
            "ublock-cookies-adguard"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "adguard-social"
            "fanboy-social"
            "fanboy-thirdparty_social"
            "adguard-popup-overlays"
            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-widgets"
            "easylist-annoyances"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "ublock-annoyances"
            "spa-1"
          ];
        };

        toAdd = {
          trustedSiteDirectives = [
            "google.com"
          ];
        };
      };
    };

    profiles.default.search = {
      force = true;
      default = "udm14";
      engines = {
        udm14 = {
          name = "udm14";
          urls = [
            { template = "https://www.google.com/search?q={searchTerms}&udm=14"; }
            {
              template = "https://www.google.com/complete/search?client=firefox&q={searchTerms}";
              type = "application/x-suggestions+json";
            }
          ];
        };

        nix-packages = {
          name = "Nix Packages";
          urls = [ { template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; } ];
          definedAliases = [ "@np" ];
        };

        nix-options = {
          name = "NixOS Options";
          urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
          definedAliases = [ "@no" ];
        };

        github = {
          name = "Github";
          urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
          definedAliases = [ "@gh" ];
        };

        home-manager-options = {
          name = "Home Manager Options";
          urls = [
            { template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}"; }
          ];
          definedAliases = [ "@hm" ];
        };
      };
    };
  };
}
