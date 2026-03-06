function note -d "Open a note in Neovim"
    set -l NOTES_DIR $HOME/Notes
    set -l SEMESTER "$NOTES_DIR/First Semester"

    argparse 'r' 'p' 'm' 'a' 't' 's' 'c' -- $argv
    or return 1

    set -l filename (string join " " $argv)

    if set -q _flag_c
        if test -z "$filename"
            echo "Usage: note -c /full/path/to/file.md" >&2; return 1
        end
        mkdir -p (dirname -- "$filename")
        nvim "$filename"
        return
    end

    set -l dir
    if set -q _flag_r; set dir "$NOTES_DIR/misc"
    else if set -q _flag_p; set dir "$SEMESTER/Engineering Physics/md"
    else if set -q _flag_m; set dir "$SEMESTER/Multivariable Calculus/md"
    else if set -q _flag_a; set dir "$SEMESTER/Applied Chemistry/md"
    else if set -q _flag_t; set dir "$SEMESTER/Technical English/md"
    else if set -q _flag_s; set dir "$SEMESTER/Problem Solving With Python/md"
    else
        echo "Usage: note [-r|-p|-m|-a|-t|-s] <filename>" >&2
        echo "       note -c /full/path/to/file.md" >&2
        return 1
    end

    if test -z "$filename"
        echo "Error: filename required" >&2; return 1
    end

    mkdir -p "$dir"
    
    # Check if file exists (case-insensitive search)
    set -l existing_file (find "$dir" -maxdepth 1 -iname "$filename" 2>/dev/null | head -1)
    
    if test -n "$existing_file"
        nvim "$existing_file"
    else
        nvim "$dir/$filename"
    end
end
