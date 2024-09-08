# not idempotent, but it doesn't matter.
export PATH="$PATH:/c/msys64/usr/bin/"

search_paths=()
for drive in {d..z}; do
  [ ! -d "/$drive" ] && break
  search_paths+=("/$drive")
done
