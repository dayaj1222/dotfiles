# Extract compressed files
function extract
    if test (count $argv) -eq 0
        echo "Usage: extract <file>"
        return
    end
    switch (basename $argv[1])
        case '*.tar.bz2'
            tar xjf $argv[1]
        case '*.tar.gz' '*.tgz'
            tar xzf $argv[1]
        case '*.tar.xz'
            tar xJf $argv[1]
        case '*.zip'
            unzip $argv[1]
        case '*.7z'
            7z x $argv[1]
        case '*'
            echo "Unknown archive format: $argv[1]"
    end
end
