set -ex

readonly WOW_FOLDER="/mnt/e/Blizzard Games/World of Warcraft/_retail_"
readonly WTF_FOLDER="$WOW_FOLDER/WTF"
readonly INTERFACE_FOLDER="$WOW_FOLDER/Interface"
readonly COPY_DIR="$(mktemp -d)"
readonly BACKUP_FILE_PATH="/tmp/$(date +"%Y_%m_%d_%H_%M_%S").zip"

cp -r "$WTF_FOLDER" "$COPY_DIR"
cp -r "$INTERFACE_FOLDER" "$COPY_DIR"

cd "$COPY_DIR"
zip --move --quiet --recurse-paths "$BACKUP_FILE_PATH" *
cd -

aws s3 cp "$BACKUP_FILE_PATH" s3://markaronin-wow-interface-backups

rm -rf $BACKUP_FILE_PATH $COPY_DIR