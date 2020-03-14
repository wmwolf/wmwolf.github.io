#! /usr/bin/env bash

/usr/bin/env ruby ~/Repositories/tutoring/_bin/gen_resources.rb vega huygens1 keck
bundle exec jekyll build --destination docs
git add --all
git commit -am "Update resources, username, password, and code."
git push