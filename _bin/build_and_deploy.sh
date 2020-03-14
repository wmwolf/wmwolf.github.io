#! /usr/bin/env bash

/usr/bin/env ruby ~/Repositories/wmwolf.github.io/_bin/gen_resources.rb student Blu1sMyHomeboy
bundle exec jekyll build --destination _site
git add --all
git commit -am "Update resources, username, password, and code."
git push