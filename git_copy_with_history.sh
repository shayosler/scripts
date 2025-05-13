#!/bin/bash -x
from_repo=$1
from_dir=$2
pattern=$3
to_repo=$4
to_dir=$5

# Filter out everything except what we want to copy from
# source repo
cd /tmp || exit 1
git clone "$REPO/$from_repo" || exit 1
cd "$from_repo" || exit 1
git remote rm origin
git filter-branch --subdirectory-filter "$from_dir" -- --all
mkdir "$from_dir"
mv ./* "$from_dir"
git add .
git commit -m "moved files"

# Copy things into destination repo
cd /tmp || exit 1
git clone "$REPO/$to_repo" || exit 1
cd "$to_repo" || exit 1
to_dir_tmp=${to_dir}_tmp
copy_branch=copy_from_${from_repo}_${from_dir}
git mv "$to_dir" "$to_dir_tmp"
git commit -m "moved $to_dir to temp location"
git remote add "$copy_branch" "/tmp/$from_repo"
git pull --no-edit "$copy_branch" master --allow-unrelated-histories

git mv "$from_dir/"$pattern "$to_dir_tmp" #Intentionally leave $pattern unquoted to allow glob
git commit -m "Moved $from_repo files to $to_dir"

git rm -r "$from_dir"
git commit -m "Deleted $from_dir"

git mv "$to_dir_tmp" "$to_dir"
git commit -m "moved $to_dir back from temp location"

git remote rm "$copy_branch"

git checkout -B "$copy_branch"
git pull
git push -u origin "$copy_branch"

# clean up
cd /tmp || exit 1
rm -rf "./$from_repo"
rm -rf "./$to_repo"
