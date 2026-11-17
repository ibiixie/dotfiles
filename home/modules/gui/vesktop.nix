{
  pkgs,
  ...
}:

{
  programs.vesktop = {
    enable = true;

    settings = {
      minimizeToTray = false;

      # not sure why but these eat a significant of background gpu
      # resulting in reduced fps when gaming by quite a lot (20%+)
      hardwareAcceleration = false;
      hardwareVideoAcceleration = false;

      arRPC = true;
    };

    vencord.settings = {
      plugins = {
        ShowMeYourName.enabled = true;
        UserMessagesPronouns.enabled = true;
        SilentTyping = {
          enabled = true;
          showIcon = true;
        };
        GameActivityToggle.enabled = true;
        PinDMs.enabled = true;
        MessageClickActions.enabled = true;
        CopyFileContents.enabled = true;
        DisableCallIdle.enabled = true;
        ValidReply.enabled = true;
        ValidUser.enabled = true;
        ExpressionManager.enabled = true;
        TypingIndicator.enabled = true;
        BetterUploadButton.enabled = true;
        FavoriteEmojiFirst.enabled = true;
        GifPaste.enabled = true;
        BetterGifPicker.enabled = true;
        WhoReacted.enabled = true;
        AlwaysExpandRoles.enabled = true;
        BetterSearch.enabled = true;
        CallTimer.enabled = true;
        FixCodeblockGap.enabled = true;
        ForceOwnerCrown.enabled = true;
        FullSearchContext.enabled = true;
        GreetStickerPicker.enabled = true;
        ImplicitRelationships.enabled = true;
        KeepCurrentChannel.enabled = true;
        MemberCount.enabled = true;
        MessageLinkEmbeds.enabled = true;
        MoreQuickReactions.enabled = true;
        MutualGroupDMs.enabled = true;
        NoUnblockToJump.enabled = true;
        PermissionFreeWill.enabled = true;
        PermissionsViewer.enabled = true;
        petpet.enabled = true;
        PlatformIndicators.enabled = true;
        PreviewMessage.enabled = true;
        ReplyTimestamp.enabled = true;
        ServerInfo.enabled = true;
        StickerPaste.enabled = true;
        TypingTweaks.enabled = true;
        Unindent.enabled = true;
        UserVoiceShow.enabled = true;
        VoiceChatDoubleClick.enabled = true;
        VolumeBooster.enabled = true;
        MentionAvatars.enabled = true;
        ShikiCodeblocks.enabled = true;
        FakeNitro.enabled = false;
        ShowConnections.enabled = true;
        ServerListIndicators.enabled = true;
        FavoriteGifSearch.enabled = true;
      };
    };
  };
}
