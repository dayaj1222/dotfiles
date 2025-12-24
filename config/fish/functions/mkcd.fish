# Make directory and enter it
function mkcd
    if test -z "$argv"
        echo "Usage: mkcd <directory>"
        return
    end
    mkdir -p $argv[1]
    cd $argv[1]
end
