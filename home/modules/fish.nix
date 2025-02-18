{
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
        set -l last_status $status

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

        printf ' '

        # Display code if previous command returned non-zero
        if test $last_status -ne 0
          set_color red -i
          printf '('
          printf $last_status
          printf ') '
        end

        set_color normal # clear italics

        # Broken heart if status code is non-zero qwq
        if test $last_status -ne 0
          set_color red -o
          printf 'Ɛ/> '
        else
          set_color brmagenta -o
          printf 'Ɛ> '
        end
      '';
    };
  };
}
