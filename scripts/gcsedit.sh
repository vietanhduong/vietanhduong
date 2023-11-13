#!/usr/bin/env bash

set -e

function usage() {
  echo -e "\nUsage: $(basename $0) [-h] URL"
  echo -e "Edit (or create) a GCS file. This program require \`gsutil\` CLI."
  echo -e "The URL is required parameter and must have the format gs://<bucket>/path/to/file"
  echo -e "Flags:"
  echo -e "\t-h, --help Show usage message"
}

function printerr() {
  echo -e "${@}" >&2
  usage
  exit 1
}

function testcmd() {
  if ! command -v $1 &> /dev/null
  then
    printerr "$1 could not be found"
  fi
}

testcmd gsutil
testcmd sha256sum

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      exit 0
      ;;
    *)
      URL="$1"
      shift
      ;;
  esac
done

if [[ -z "$URL" ]]; then
  printerr "Error: missing URL"
fi

if [[ $URL == */ ]]; then
  printerr "Error: URL must be a file"
fi

set +e
content="$(gsutil cat $URL 2>/dev/null)"
if [[ $? -ne 0 ]]; then
  create=true
fi

set -e

tmpdir=$(mktemp -d "/tmp/$(dirname "${URL#"gs://"}").XXXXXX")
tmpfile="$tmpdir/$(basename $URL)"
trap 'rm -rf $tmpdir' ERR EXIT

touch $tmpfile
if [[ -n "$content" ]]; then
  echo "$content" > $tmpfile
fi

prev_hash=$(sha256sum $tmpfile | awk '{print $1}')
if [[ -z "$EDITOR" ]]; then
  EDITOR=vim
fi

$EDITOR $tmpfile

cur_hash=$(sha256sum $tmpfile | awk '{print $1}')
if [[ "$cur_hash" == "$prev_hash" ]]; then
  echo "Edit cancelled, no changes made."
  exit 0
fi

gsutil cp $tmpfile $URL
