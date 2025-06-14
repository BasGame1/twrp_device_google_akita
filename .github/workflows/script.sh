#!/bin/bash
DEPENDENCIES_FILE=$1
LOCAL_MANIFEST_DIR=".repo/local_manifests"
LOCAL_MANIFEST_FILE="${LOCAL_MANIFEST_DIR}/twrp_dependencies.xml"

if [ ! -f "$DEPENDENCIES_FILE" ]; then
    echo "Error: Dependencies file not found: $DEPENDENCIES_FILE"
    exit 1
fi

mkdir -p "$LOCAL_MANIFEST_DIR"
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$LOCAL_MANIFEST_FILE"
echo "<manifest>" >> "$LOCAL_MANIFEST_FILE"
echo "  <project path=\"$(dirname $DEPENDENCIES_FILE)\" name=\"$(basename $(dirname $DEPENDENCIES_FILE))\" />" >> "$LOCAL_MANIFEST_FILE" # Add your own device tree
cat "$DEPENDENCIES_FILE" | jq -r '.[] | "<project path=\"\(.target_path)\" name=\"\(.repository | split("/") | .[4] | sub(\".git$\"; \"\"))\" remote=\"\(.repository | split("//") | .[1] | split("/") | .[0])\" revision=\"\(.branch)\"/>"' >> "$LOCAL_MANIFEST_FILE" # This part needs jq for JSON parsing
echo "</manifest>" >> "$LOCAL_MANIFEST_FILE"

echo "Generated local manifest:"
cat "$LOCAL_MANIFEST_FILE"
