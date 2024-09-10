{ config, lib, pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-empty-string = {
    Value = "";
    Status = "locked";
  };
in {
  options = {
    modules.firefox.enable = lib.mkEnableOption "enable firefix system-wide";
  };

  config = lib.mkIf config.modules.firefox.enable {
    programs.firefox = {
      enable = true;

      preferences = {
        "biixie.breadcrumb" = true;
        "app.normandy.api_url" = "";
	"app.normandy.enabled" = false;
	"app.shield.optoutstudies.enabled" = false;
	"app.update.auto" = false;
	"beacon.enabled" = false;
	"breakpad.reportURL" = "";
	"browser.aboutConfig.showWarning" = false;
	"browser.cache.offline.enable" = false;
	"browser.crashReports.unsubmittedCheck.autoSubmit" = false;
	"browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
	"browser.crashReports.unsubmittedCheck.enabled" = false;
	"browser.disableResetPrompt" = true;
	"browser.newtab.preload" = false;
	"browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
	"browser.newtabpage.introShown" = true;
	"browser.safebrowsing.appRepURL" = "";
	"browser.safebrowsing.blockedURIs.enabled" = false;
	"browser.safebrowsing.downloads.enabled" = false;
	"browser.safebrowsing.downloads.remote.enabled" = false;
	"browser.safebrowsing.downloads.remote.url" = "";
	"browser.safebrowsing.enabled" = false;
	"browser.safebrowsing.malware.enabled" = false;
	"browser.safebrowsing.phishing.enabled" = false;
	"browser.selfsupport.url" = "";
	"browser.send_pings" = false;
	"browser.sessionstore.privacy_level" = 0;
	"browser.shell.checkDefaultBrowser" = false;
	"browser.startup.homepage_override.mstone" = "ignore";
	"browser.tabs.crashReporting.sendReport" = false;
        "browser.urlbar.groupLabels.enabled" = false;
	"browser.urlbar.quicksuggest.enabled" = false;
	"browser.urlbar.speculativeConnect.enabled" = false;
	"browser.urlbar.trimURLs" = false;
	"datareporting.healthreport.service.enabled" = false;
	"datareporting.healthreport.uploadEnabled" = false;
	"device.sensors.ambientLight.enabled" = false;
	"device.sensors.enabled" = false;
	"device.sensors.motion.enabled" = false;
	"device.sensors.orientation.enabled" = false;
	"device.sensors.proximity.enabled" = false;
	"dom.battery.enabled" = false;
	"dom.private-attribution.submission.enabled" = false;
	"dom.security.https_only_mode" = true;
	"dom.security.https_only_mode_ever_enabled" = true;
	"experiments.activeExperiment" = false;
	"experiments.enabled" = false;
	"experiments.manifest.uri" = "";
	"experiments.supported" = false;
	"extensions.autoDisableScopes" = 14;
	"extensions.getAddons.cache.enabled" = false;
	"extensions.getAddons.showPane" = false;
	"extensions.greasemonkey.stats.optedin" = false;
	"extensions.greasemonkey.stats.uri" = "";
	"extensions.pocket.enabled" = false;
	"extensions.shield-recipe-client.api_url" = "";
	"extensions.shield-recipe-client.enabled" = false;
	"extensions.webservice.discoverURL" = "";
	"media.autoplay.default" = 0;
	"media.autoplay.enabled" = true;
	"media.navigator.enabled" = false;
	"network.allow-experiments" = false;
	"network.captive-portal-service.enabled" = false;
	"network.cookie.cookieBehavior" = 1;
	"network.dns.disablePrefetch" = true;
	"network.dns.disablePrefetchFromHTTPS" = true;
	"network.http.referer.spoofSource" = true;
	"network.http.speculative-parallel-limit" = 0;
	"network.predictor.enable-prefetch" = false;
	"network.predictor.enabled" = false;
	"network.prefetch-next" = false;
	"network.trr.mode" = 5;
	"privacy.donottrackheader.enabled" = true;
	"privacy.donottrackheader.value" = 1;
	"privacy.query_stripping" = true;
	"privacy.trackingprotection.cryptomining.enabled" = true;
	"privacy.trackingprotection.enabled" = true;
	"privacy.trackingprotection.fingerprinting.enabled" = true;
	"privacy.trackingprotection.pbmode.enabled" = true;
	"privacy.usercontext.about_newtab_segregation.enabled" = true;
	"security.ssl.disable_session_identifiers" = true;
	"services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
	"signon.autofillForms" = false;
	"toolkit.telemetry.archive.enabled" = false;
	"toolkit.telemetry.bhrPing.enabled" = false;
	"toolkit.telemetry.cachedClientID" = "";
	"toolkit.telemetry.enabled" = false;
	"toolkit.telemetry.firstShutdownPing.enabled" = false;
	"toolkit.telemetry.hybridContent.enabled" = false;
	"toolkit.telemetry.newProfilePing.enabled" = false;
	"toolkit.telemetry.propmted" = 2;
	"toolkit.telemetry.rejected" = true;
	"toolkit.telemetry.reportingpolicy.firstRun" = false;
	"toolkit.telemetry.server" = "";
	"toolkit.telemetry.shutdownPingSender.enabled" = false;
	"toolkit.telemetry.unified" = false;
	"toolkit.telemetry.unifiedIsOptIn" = false;
	"toolkit.telemetry.updatePing.enabled" = false;
      };

      policies = {
        ExtensionSettings = {
          # block all other
	  "*".installation_mode = "blocked";

          # ublock-origin
	  "uBlock0@raymondhill.net" = {
	    installation_mode = "force_installed";
	    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
	  };

	  # bitwarden-password-manager
	  "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
	    install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
	  };

	  # bypass-paywalls-clean
          "magnolia@12.34" = {
	    installation_mode = "force_installed";
	    install_url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/?file=bypass_paywalls_clean-latest.xpi&branch=main";
	  };

          # return-youtube-dislikes
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
            installation_mode = "force_installed";
	    install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
	  };

	  # languagetool
          "languagetool-webextension@languagetool.org" = {
	    installation_mode = "force_installed";
	    install_url = "https://addons.mozilla.org/firefox/downloads/latest/languagetool/latest.xpi";
	  };

	  # youtube-shorts-block
	  "{34daeb50-c2d2-4f14-886a-7160b24d66a4}" = {
            installation_mode = "force_installed";
	    install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-shorts-block/latest.xpi";
	  };
	};

	NewTabPage = false;
	DisplayMenuBar = false;
	DisableFirefoxAccounts = false;
	NetworkPrediction = false;
	CaptivePortal = false;
	DNSOverHTTPS = { Enabled = false; };
	DisableFirefoxStudies = true;
	DisableTelemetry = true;
	DisablePocket = true;
      };
    };
  };
}
