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
        string join -- \
          (set_color cyan) '[ ' \
          (set_color brmagenta) (whoami) '@' (hostname) \
          ' ' \
          (set_color normal) (prompt_pwd) \
          (set_color cyan) ' ]' \
          (set_color cyan) (fish_git_prompt) \
          (set_color brmagenta) ' Ɛ> '
      '';
    };
  };
}
