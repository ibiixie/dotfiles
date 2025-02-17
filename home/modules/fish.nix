{
  config,
  lib,
  pkgs,
  ...
}:

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

      battery = "cat /sys/class/power_supply/BAT0/capacity";
    };

    functions = {
      fish_greeting = ''
        # hyfetch 
      '';

      fish_prompt = ''
        set_color cyan
        printf '[ '
        
        set_color brmagenta -o
        printf (whoami)
        printf '@'
        printf (hostname)

        printf ' '

        set_color normal
        printf (prompt_pwd)

        set_color cyan
        printf ' ]'

        set_color green -i
        printf (fish_git_prompt)

        set_color normal # clear italics
        set_color brmagenta -o
        printf ' Ɛ> '
      '';
    };
  };
}
