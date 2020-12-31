#! /usr/bin/env bash

# this script should be run from the root directory of the source dir
# git commands require this. The host directory is accesseed manually

source_dir=$HOME/Repositories/website-source
host_dir=$HOME/Repositories/wmwolf.github.io
username=student
password=password


# update source material: quizzes and papers
/usr/bin/env ruby $source_dir/_bin/gen_resources.rb "$username" "$password" quizzes
/usr/bin/env python $source_dir/_bin/update_papers.py
git add --all
git commit -am "$@"
git push

# build website to host repo and deploy
bundle exec jekyll build --destination "$host_dir"
git -C "$host_dir" add --all
git -C "$host_dir" commit -am "$@"
git -C "$host_dir" push