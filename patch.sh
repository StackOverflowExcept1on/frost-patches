#!/usr/bin/env bash
set -ex

export LANG="en_US.UTF-8"
COMMIT_DATE="$(date)"

# tested on 39b61ec9da75c73476f1573a0781fb87069d86b1
git clone git@github.com:ZcashFoundation/frost.git
cd frost

cp -r frost-secp256k1 frost-secp256k1-backup

git am ../0001-feat-add-frost-secp256k1-evm-crate.patch
git commit --amend --no-edit --date "$COMMIT_DATE"

mv frost-secp256k1-backup frost-secp256k1

git add --all
git commit --message "chore: \`git checkout frost-secp256k1\`"

git am ../0002-fix-add-missing-stuff-to-frost-secp256k1.patch
git commit --amend --no-edit --date "$COMMIT_DATE"

git am ../0003-feat-bump-MSRV-to-1.81-make-all-crates-no_std.patch
git commit --amend --no-edit --date "$COMMIT_DATE"

git am ../0004-feat-frost-core-simplify-trait-bounds-don-t-use-the-allocator-in-some-places.patch
git commit --amend --no-edit --date "$COMMIT_DATE"

git am ../0005-chore-enable-CI-for-other-branches.patch
git commit --amend --no-edit --date "$COMMIT_DATE"
