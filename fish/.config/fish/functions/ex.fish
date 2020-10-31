function ex --description "Function to extract most types of archives"
    if test -f $argv
        switch $argv
            case --help
                echo "usage: ex <file>"
            case *.tar.bz2
                tar xjf $argv
            case *.tar.gz
                tar xzf $argv
            case *.bz2
                bunzip2 $argv
            case *.rar
                unrar x $argv
            case *.gz
                gunzip $argv
            case *.tar
                tar xf $argv
            case *.tbz2
                tar xjf $argv
            case *.tgz
                tar xzf $argv
            case *.zip
                unzip $argv
            case *.Z
                uncompress $argv
            case *.7z
                7z x $argv
            case *.deb
                tar x $argv
            case *.tar.xz
                tar xf $argv
            case *.tar.zst
                unzstd $argv
            case *
                echo "'$argv' cannot be extracted via ex"
        end
    else
        echo "'$argv' is not a valid file"
    end
end
