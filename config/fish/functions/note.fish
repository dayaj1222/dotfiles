function note -d "Open a note in Neovim"

    set -l NOTES_DIR $HOME/Notes
    set -l SEM "$NOTES_DIR/First Semester"

    argparse 'p' 'm' 'c' 'e' 's' 'x' 'f' -- $argv
    or return 1

    set -l filename (string join " " $argv)

    # custom file
    if set -q _flag_f
        if test -z "$filename"
            echo "Usage: note -f /full/path/file.md" >&2
            return 1
        end
        mkdir -p (dirname "$filename")
        nvim "$filename"
        return
    end

    # subject directories
    if set -q _flag_p
        set dir "$SEM/Engineering Physics/md"
    else if set -q _flag_m
        set dir "$SEM/Multivariable Calculus/md"
    else if set -q _flag_c
        set dir "$SEM/Applied Chemistry/md"
    else if set -q _flag_e
        set dir "$SEM/Technical English/md"
    else if set -q _flag_s
        set dir "$SEM/Problem Solving With Python/md"
    else if set -q _flag_x
        set dir "$NOTES_DIR/misc"
    else
        echo "Use subject flag: -p -m -c -e -s -x" >&2
        return 1
    end

    if test -z "$filename"
        echo "Provide note name" >&2
        return 1
    end

    if not string match -q "*.md" "$filename"
        set filename "$filename.md"
    end

    mkdir -p "$dir"
    nvim "$dir/$filename"

end
