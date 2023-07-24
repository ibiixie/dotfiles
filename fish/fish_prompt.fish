#function fish_prompt
    #echo (set_color brmagenta)$USER(set_color yellow) (prompt_pwd)(set_color brwhite)' > '
#end


# xela@pop-os ~ (git-branch) > 
function fish_prompt
    # set -eg ___fish_git_prompt_char_stateseparator; and set -U ___fish_git_prompt_char_stateseparator ""
    set -g __fish_git_prompt_showupstream auto

    echo \
    (set_color brmagenta)$USER@$hostname \
    (set_color yellow)(prompt_pwd) \
    (set_color red)(fish_vcs_prompt) \
    (set_color cyan)"Ɛ> "
end
