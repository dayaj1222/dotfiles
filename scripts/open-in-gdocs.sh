#!/bin/bash
# open-in-gdocs.sh — Upload a local file to Google Drive and open it in the browser
set -euo pipefail

# ── Configuration ────────────────────────────────────────────────────────────
REMOTE="gdrive"
UPLOAD_DIR="${REMOTE}:.tmp_uploads"
BROWSER="${BROWSER:-zen-browser}"
# ─────────────────────────────────────────────────────────────────────────────

usage() {
    echo "Usage: $(basename "$0") <file>" >&2
    echo "       Uploads a .docx/.xlsx/.pptx (and variants) to Google Drive and opens it." >&2
    exit 1
}

die() { echo "ERROR: $*" >&2; exit 1; }

# ── Argument validation ───────────────────────────────────────────────────────
[[ $# -eq 1 ]] || usage
FILE_PATH="$1"
[[ -f "$FILE_PATH" ]] || die "File not found: $FILE_PATH"

FILE_NAME="$(basename "$FILE_PATH")"
EXTENSION="${FILE_NAME##*.}"
EXTENSION="${EXTENSION,,}"

# ── Extension → Drive type mapping ───────────────────────────────────────────
case "$EXTENSION" in
    xlsx|xls|csv)
        IMPORT_FORMATS="xlsx,xls,csv"
        URL_PREFIX="spreadsheets"
        ;;
    pptx|ppt)
        IMPORT_FORMATS="pptx,ppt"
        URL_PREFIX="presentation"
        ;;
    docx|doc|txt|rtf|odt)
        IMPORT_FORMATS="docx,doc,txt,rtf,odt"
        URL_PREFIX="document"
        ;;
    *)
        die "Unsupported file type: .$EXTENSION"
        ;;
esac

# ── Upload (single call) + capture ID ────────────────────────────────────────
echo "Uploading '$FILE_NAME' ..."

# Force re-upload even if file exists (--ignore-checksum), so verbose output
# always contains the transfer line we can grep for the ID.
RCLONE_OUT="$(
    rclone copyto "$FILE_PATH" "$UPLOAD_DIR/$FILE_NAME" \
        --drive-import-formats "$IMPORT_FORMATS" \
        --drive-upload-cutoff 0 \
        --ignore-checksum \
        --verbose 2>&1
)"

echo "$RCLONE_OUT"

# Try to parse the file ID from rclone's verbose URL output
FILE_ID="$(echo "$RCLONE_OUT" | grep -oP '(?<=/d/)[a-zA-Z0-9_-]+' | head -n1 || true)"

# Fallback: query Drive directly (only if grep came up empty)
if [[ -z "$FILE_ID" ]]; then
    echo "ID not in upload output, querying Drive ..."
    FILE_ID="$(
        rclone lsjson "$UPLOAD_DIR" --files-only \
        | jq -r --arg name "$FILE_NAME" '.[] | select(.Name == $name) | .ID' \
        | head -n1
    )"
fi

[[ -n "$FILE_ID" ]] || die "Could not retrieve file ID for '$FILE_NAME'."

# ── Open in browser ───────────────────────────────────────────────────────────
URL="https://docs.google.com/${URL_PREFIX}/d/${FILE_ID}/edit"
echo "Opening: $URL"
"$BROWSER" "$URL"
