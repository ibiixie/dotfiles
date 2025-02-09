{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # sometimes you have to ask kindly c:
      pls = "sudo";
      please = "sudo";
    };

    shellAbbrs = {
      # Git.
      ga = "git add";
      gc = "git commit -m";
      gp = "git push";
    };

    functions = {
      fish_greeting = ''
        # Keep it empty for now! 
      '';
    };
  };
}
