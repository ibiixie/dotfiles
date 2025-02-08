{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    functions = {
      fish_greeting = ''
        # Keep it empty for now! 
      '';
    };
  };
}
