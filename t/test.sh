#!/bin/sh

set -e # die if any command fails
set -x # verbose
export CARTON_LOCAL_STASH_VERBOSE=1

TEMP_REPO=$(mktemp -d)
GIT_ROOT=$(git rev-parse --show-toplevel)
cp "$GIT_ROOT/post-checkout" "$TEMP_REPO"
cd "$TEMP_REPO"
git init

# set dummy identities for Travis CI
git config --local user.email "test@example.com"
git config --local user.name "test"

mv post-checkout .git/hooks

git commit --allow-empty -m empty

git checkout -b A
echo "requires 'A';" > cpanfile
git add cpanfile && git commit -m A
mkdir local && touch local/A

git checkout -b B
[ -f local/A ] || exit 1;
echo "requires 'B';" > cpanfile
git add cpanfile && git commit -m B
touch local/B

git checkout master
[ ! -d local ] || exit 1;

git checkout A
[ -f local/A ] || exit 1;

git checkout B
[ -f local/B ] || exit 1;

rm -rf "$TEMP_REPO"
