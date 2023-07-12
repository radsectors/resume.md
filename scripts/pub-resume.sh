#!/bin/sh

src_file="resume.md"
pub_dir="pub-resume"
out_name="resume"

if [ ! -d $pub_dir ]; then
    mkdir $pub_dir
    cp -f .gitignore-pub $pub_dir/.gitignore
fi

cp -f resume.md $pub_dir/README.md

scripts/make "$PWD/$pub_dir/README.md" "$PWD/$pub_dir/$out_name"

if [ $? -eq 1 ]; then
    echo "File generation failed."
    return 1
fi

# switch to pub dir
cd $pub_dir

if [ ! -d .git ]; then
    git init
fi

# check gitconfig
git remote get-url origin

if [ $? != 0 ]; then
    echo "Please enter remote URL: "
    read git_remote

    git remote add origin $git_remote
    git branch main
fi

git rm -r --cached .
git add --all

git commit --amend -m "resume"
if [ $? != 0 ]; then
    git commit -m "resume"
fi

git push origin main --force

cd ..
