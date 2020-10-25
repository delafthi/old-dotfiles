function fish_mode_prompt
    fish_vi_cursor
    switch $fish_bind_mode
        case default
            set_color green
            echo '[NORMAL]'
        case insert
            echo ''
        case replace_one
            set_color green
            echo '[NORMAL]'
        case replace
            set_color red
            echo '[REPLACE]'
        case visual
            set_color yellow
            echo '[VISUAL]'
        case '*'
            set_color --bold red
            echo '[???]'
    end
    set_color normal
end
