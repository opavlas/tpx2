#!/bin/bash
# Which commit is a given build id -- and is the live site up to date?
#
# The pages carry a build stamp: a date and an 8-hex fingerprint of the page
# source plus its own data bundles (deploy_site.py writes it). That id is a
# CONTENT hash, not a git id, so it does not look like a commit -- but it is
# stored inside the committed index.html, which makes git itself the lookup.
#
#   ./whichbuild.sh            compare the live site against HEAD
#   ./whichbuild.sh 2068f416   name the commit carrying that build
#
# Why a content hash and not the commit SHA: the page is built BEFORE it is
# committed, so it cannot contain its own commit id. Hashing the bytes instead
# means the id changes exactly when the served bytes change -- including when
# only a data bundle moves and the markup does not, which is the case a size
# or diff check misses.

set -u
SITE="https://opavlas.github.io/tpx2"
cd "$(dirname "$0")" || exit 1

find_commit() {            # $1 = build id
  local want="$1" c
  for c in $(git log --format=%H -n 200); do
    if git show "$c:index.html" 2>/dev/null | grep -q "content=\"$want\""; then
      git log -1 --date=short --format="%h  %ad  %s" "$c"
      return 0
    fi
  done
  echo "not found in the last 200 commits"
}

build_of() {               # $1 = a file's contents on stdin
  grep -o 'name="build" content="[0-9a-f]*"' | head -1 | sed 's/.*content="//;s/"//'
}

if [ $# -ge 1 ]; then
  printf 'build %s -> %s\n' "$1" "$(find_commit "$1")"
  exit 0
fi

head_build=$(git show HEAD:index.html 2>/dev/null | build_of)
live_build=$(curl -s "$SITE/" 2>/dev/null | build_of)

printf 'HEAD  %s  build %s\n' "$(git log -1 --format=%h)" "${head_build:-?}"
printf 'live  %s\n' "${live_build:-unreachable}"

if [ -z "$live_build" ]; then
  echo
  echo "could not read the live site"
elif [ "$head_build" = "$live_build" ]; then
  echo
  echo "UP TO DATE -- the live site is serving HEAD"
else
  echo
  echo "STALE -- live is serving:"
  printf '  %s\n' "$(find_commit "$live_build")"
  ahead=$(git rev-list --count "origin/main..HEAD" 2>/dev/null || echo "?")
  if [ "$ahead" != "0" ]; then
    echo "  and HEAD is $ahead commit(s) unpushed -- push first"
  else
    echo "  HEAD is pushed, so GitHub Pages has not rebuilt yet."
    echo "  Check Settings -> Pages, or the repo's Deployments tab, for a failed build."
  fi
fi
