function fish_prompt
    set_color $fish_color_user
    echo -n (whoami)
    set_color normal
    echo -n '@'
    set_color $fish_color_host
    echo -n 'TDTPE15'
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n (fish_vcs_prompt)
    set_color blue
    echo -n '$ '
end
