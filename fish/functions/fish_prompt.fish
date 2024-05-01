function fish_prompt
    set -g __fish_get_prompt_showupstream auto

    echo \
    (set_color brmagenta)$USER@$hostname \
    (set_color yellow)(prompt_pwd) \
    (set_color red)(fish_vcs_prompt) \
    (set_color cyan)"Ɛ> "
end
