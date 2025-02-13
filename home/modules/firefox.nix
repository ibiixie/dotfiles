{
  inputs,
  config,
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "biixie";
        isDefault = true;

        settings = {
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";

          "browser.newtabpage.activity-stream.showWeather" = true;

          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;

          "PasswordManagerEnabled" = false;

          # Improve smooth scroll (Smoothfox.js)
          "apz.overscroll.enabled" = true;
          "general.smoothScroll" = true;
          "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2;
          "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          "general.smoothScroll.currentVelocityWeighting" = 1;
          "general.smoothScroll.stopDecelerationWeighting" = 1;
          "mousewheel.default.delta_multiplier_y" = 300; # adjust between 250-400

          # Fastfox
          "content.notify.interval" = 100000;
          "gfx.canvas.accelerated.cache-items" = 4096;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          "browser.cache.disk.enable" = true;
          "media.memory_cache_max_size" = 65536;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.dnsCacheExpiration" = 3600;
          "network.ssl_tokens_cache_capacity" = 10240;
          "network.prefetch-next" = false;

          # FF Nightly
          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;

          "browser.contentblocking.category" = "strict";
          "urlclassifier.trackingSkipURLs" = [
            "*.reddit.com"
            "*.twitter.com"
            "*.twimg.com"
            "*.tiktok.com"
          ];
          "urlclassifier.features.socialtracking.skipURLs" = [
            "*.instagram.com"
            "*.twitter.com"
            "*.twimg.com"
          ];
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;

          "security.OCSP.enabled" = 0;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;

          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;

          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "browser.sessionstore.interval" = 60000;

          "browser.privatebrowsing.resetPBM.enabled" = true;
          "privacy.history.custom" = true;

          "browser.urlbar.trimHttps" = true;
          "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.urlbar.update2.engineAliasRefresh" = true;

          "browser.search.suggest.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;

          "browser.urlbar.groupLabels.enabled" = false;
          "browser.formfill.enable" = false;
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          "network.IDN_show_punycode" = true;

          "dom.security.https_first" = true;

          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;

          "security.mixed_content.block_display_content" = true;
          "pdfjs.enableScripting" = false;

          "extensions.enabledScopes" = 5;

          "network.http.referer.XOriginTrimmingPolicy" = 2;

          "privacy.userContext.ui.enabled" = true;

          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 2;
          "browser.search.update" = false;
          "permissions.manager.defaultsUrl" = "";

          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;

          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";

          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;

          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;

          # Peskyfox
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.profiles.enabled" = true;

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.compactmode.show" = true;

          "cookiebanners.service.mode" = 1;
          "cookiebanners.service.mode.privateBrowsing" = 1;

          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.timeout" = 0;

          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.urlbar.trending.featureGate" = false;

          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

          "extensions.pocket.enabled" = false;

          "browser.download.manager.addToRecentDocs" = false;

          "browser.download.open_pdf_attachments_inline" = true;

          "browser.bookmarks.openInTabClosesMenu" = false;
          "browser.menu.showViewImageInfo" = true;
          "findbar.highlightAll" = true;
          "layout.word_select.eat_space_to_next_word" = false;

          # Performance/hardware acceleration
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.ffvpx.enabled" = false;
          "media.rdd-vpx.enabled" = false;
          "widget.dmabuf.force-enabled" = true;

          # Update using flake, not through firefox itself
          "app.update.auto" = false;

          # DRM
          "media.eme.enabled" = true;

          "browser.aboutwelcome.didSeeFinalScreen" = true;
          "browser.disableResetPrompt" = true;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.topSitesRows" = 2;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored" = false;
          "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.weather" = false;
          "browser.urlbar.suggest.yelp" = false;
          "browser.newtabpage.enabled" = true;
          "browser.newtabpage.enhanced" = false;
          "browser.newtabpage.introShown" = true;
          "browser.newtabpage.pinned" = [ ];
          "browser.startup.homepage_override.mstone" = false;
          "browser.startup.page" = 3;
          "extensions.autoDisableScopes" = 0; # Enable addons by default
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "signon.autofillForms" = false;
          "signon.firefoxRelay.feature" = "disabled";
          "signon.generation.enabled" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;

          # Prefetch and prediction
          "browser.newtab.preload" = false;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.predictor.enable-prefetch" = false;
          "network.predictor.enabled" = false;
          "network.http.speculative-parallel-limit" = 0;
          "network.http.speculative-parallel.limit" = 0;

          # Telemetry/privacy/security
          "app.normany.app_url" = "";
          "beacon.enabled" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "browser.crashReports.ubsubmittedCheck.enabled" = false;
          "browser.safebrowsing.appRepURL" = "";
          "browser.safebrowsing.blockedURIs.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safesupport.url" = "";
          "browser.send_pings" = false;
          "datareporting.healthreport.service.enabled" = false;
          "dom.private-attribution.submission.enabled" = false;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";
          "experiments.supported" = false;
          "extensions.shield-recipe-client.api_url" = "";
          "extensions.shield-recipe-client.enabled" = false;
          "extensions.webservice.discoverURL" = "";
          "network.allow-experiments" = false;
          "toolkit.telemetry.cachedClientID" = "";
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.propmted" = 2;
          "toolkit.telemtry.unifiedIsOptIn" = false;
        };

        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          order = [ "DuckDuckGo" ];
          engines = {
            "DuckDuckGo" = {
              urls = [ { template = "https://duckduckgo.com/?q={searchTerms}"; } ];
              iconUpdateURL = "https://duckduckgo.com/favicon.png";
              updateInteval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@ddg" ];
            };

            # Disable default search engines
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
        };
      };
    };

    # https://mozilla.github.io/policy-templates
    policies = {
      DisableAppUpdate = true;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      CaptivePortal = false;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisableMasterPasswordCreation = true;
      DisablePocket = true;
      DisableProfileRefresh = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "never";
      DontCheckDefaultBrowser = true;

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      EncryptedMediaExtensions = {
        Enabled = true;
      };

      # Note: UUIDs have to be surrounded by squiggly brackets!
      ExtensionSettings = {
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          default_area = "navbar";
        };

        # ublock-origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "menupanel";
        };

        # skip-redirect
        "skipredirect@sblask" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
          default_area = "menupanel";
        };

        # no-pdf-download
        "{b9b25e4a-bdf4-4270-868c-3f619eaf437d}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/no-pdf-download/latest.xpi";
          default_area = "menupanel";
        };

        # translate-web-pages
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
          default_area = "menupanel";
        };

        # youtube-shorts-block
        "{34daeb50-c2d2-4f14-886a-7160b24d66a4}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-shorts-block/latest.xpi";
          default_area = "menupanel";
        };

        # youtube-nonstop
        "{0d7cafdd-501c-49ca-8ebb-e3341caaa55e}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-nonstop/latest.xpi";
          default_area = "menupanel";
        };

        # return-youtube-dislikes
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          default_area = "menupanel";
        };

        # i still dont care about cookies
        "idcac-pub@guus.ninja" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
          default_area = "menupanel";
        };

        # web archives
        "{d07ccf11-c0cd-4938-a265-2a4d6ad01189}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/view-page-archive/latest.xpi";
          default_area = "navbar";
        };

        # redirector
        "redirector@einaregilsson.com" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/redirector/latest.xpi";
          default_area = "menupanel";
        };

        # betterTTV
        "firefox@betterttv.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/betterttv/latest.xpi";
          default_area = "menupanel";
        };

        # chrome-mask
        "chrome-mask@overengineer.dev" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/chrome-mask/latest.xpi";
          default_area = "menupanel";
        };
      };

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };

      FirefoxSuggest = {
        WebSuggestions = true;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      HardwareAcceleration = true;

      Homepage = {
        URL = "about:home";
        StartPage = "previous-session"; # "homepage";
      };

      HttpAllowlist = [
        "127.0.0.1"
        "0.0.0.0"
        "localhost"
      ];

      HttpsOnlyMode = "enabled";

      NetworkPrediction = false;

      NewTabPage = true;

      NoDefaultBookmarks = true;

      OfferToSaveLogins = false;

      OfferToSaveLoginsDefault = false;

      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      PasswordManagerEnabled = false;

      PrimaryPassword = false;

      PromptForDownloadLocation = false;

      SearchBar = "unified"; # "separate";

      SearchSuggestEnabled = true;

      # I use an extension for this!
      TranslateEnabled = false;

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = false;
        MoreFromMozilla = false;
        FirefoxLabs = false;
      };
    };
  };
}
