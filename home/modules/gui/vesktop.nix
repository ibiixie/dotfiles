{
  pkgs,
  ...
}:

{
  # home.packages = [
  #   pkgs.vesktop
  # ];

  stylix.targets.vesktop.enable = false;

  programs.vesktop = {
    enable = true;

    settings = {
      minimizeToTray = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      arRPC = true;
    };

    vencord.extraQuickCss = builtins.readFile (
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/round-panda/gruvbox-sharp/54f0612a1d0fb38d3f2c7a7f4b697b5ad607d312/GruvboxSharp.theme.css";
        hash = "sha256-fRj80A/foM6Bc6odECU2JuYrLhxuknbqot7QL3TUqWo=";
      }
    );

    vencord.settings = {
      plugins = {
        BetterNotesBox.enabled = true;
        BetterRoleContext.enabled = true;
        CopyUserURLs.enabled = true;
        CopyStickerLinks.enabled = true;
        GreetStickerPicker.enabled = true;
        ImageZoom.enabled = true;
        MentionAvaters.enabled = true;
        MessageClickActions.enabled = true;
        NoUnblockToJump.enabled = true;

        FakeNitro.enabled = true;
        AnonymiseFileNames.enabled = true;
        BetterFolders.enabled = true;
        CallTimer.enabled = true;
        CopyFileContents.enabled = true;
        DisableCallIdle.enabled = true;
        BetterGifAltText.enabled = true;
        BetterUploadButton.enabled = true;
        CustomIdle = {
          enabled = true;

          idleTimeout = 60;
          remainInIdle = false;
        };
        DisableDeepLinks.enabled = true;
        ExpressionCloner.enabled = true;
        FavoriteEmojiFirst.enabled = true;
        FixImagesQuality.enabled = true;
        FriendsSince.enabled = true;
        GameActivityToggle.enabled = true;
        GifPaste.enabled = true;
        ImageFilename.enabled = true;
        MemberCount.enabled = true;
        MessageLinkEmbeds.enabled = true;
        PermissionFreeWill.enabled = true;
        PermissionsViewer.enabled = true;
        PinDMs.enabled = true;
        PreviewMessage.enabled = true;
        ReplyTimestamp.enabled = true;
        ServerInfo.enabled = true;
        ShikiCodeblocks.enabled = true;
        ShowMeYourName.enabled = true;
        StickerPaste.enabled = true;
        TypingIndicator.enabled = true;
        TypingTweaks.enabled = true;
        ValidUser.enabled = true;
        ValidReply.enabled = true;
        ViewIcons.enabled = true;
        VoiceChatDoubleClick.enabled = true;
        WhoReacted.enabled = true;
        WebScreenShareFixes.enabled = true;
        VolumeBooster.enabled = true;
        WebContextMenus.enabled = true;
        UserVoiceShow.enabled = true;
        UserMessagesPronouns.enabled = true;
        Unindent.enabled = true;
        SuperReactionTweaks.enabled = true;
        SortFriendRequests.enabled = true;
        ShowConnections.enabled = true;
        ReviewDB.enabled = true;
        RevealAllSpoilers.enabled = true;
        PlatformIndicators.enabled = true;
        petpet.enabled = true;
        PlainFolderIcon.enabled = true;
        ServerListIndicators.enabled = true;
        ShowHiddenChannels.enabled = true;
        ShowHiddenThings.enabled = true;
        ShowTimeoutDuration.enabled = true;
        SilentTyping = {
          enabled = true;
          showIcon = true;
        };
        OpenInApp.enabled = true;
        NoTrack.enabled = true;
        MutualGroupDMs.enabled = true;
        MoreQuickReactions.enabled = true;
        KeepCurrentChannel.enabled = true;
        ImplicitRelationships.enabled = true;
        FullUserInChatbox.enabled = true;
        FullSearchContext.enabled = true;
        ForceOwnerCrown.enabled = true;
        FixYoutubeEmbeds.enabled = true;
        FixSpotifyEmbeds.enabled = true;
        FavoriteGifSearch.enabled = true;
        FixCodeblockGap.enabled = true;
        Experiments.enabled = true;
        CharacterCounter.enabled = true;
        BiggerStreamPreview.enabled = true;
        BetterSettings.enabled = true;
        BetterSessions.enabled = true;
        BetterRoleDot.enabled = true;
        BetterGifPicker.enabled = true;
        AlwaysExpandRoles.enabled = true;
        AlwaysAnimate.enabled = true;
        AccountPanelServerProfile.enabled = true;
      };
    };
  };

  # using the vesktop setting instead which seems to conflict with this
  # services.arrpc.enable = true;
}
