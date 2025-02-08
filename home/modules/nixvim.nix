{ config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      updatetime = 100;
      swapfile = false;

      number = true;
      relativenumber = true;

      cursorline = true;

      sidescrolloff = 10;
      wrap = false;

      fileencoding = "utf-8";

      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
    };
  };
}

