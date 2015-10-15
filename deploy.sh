#!/bin/bash

set -o errexit -o nounset

rev=$(git rev-parse --short HEAD)

# RUN PANDOC and create HTML
mkdir html
for i in *md; do
  pandoc -s $i -o html/${i%%md}html;
done

cd html
rm README.html
git init


git config user.name "lrsantiago"
git config user.email "l.santiago@qmul.ac.uk"
git remote add deploy "https://$GH_TOKEN@github.com/wurmlab/SBC361-programming-in-R.git"

git fetch deploy gh-pages
git reset deploy/gh-pages

git add -A .
git commit -m "build website at ${rev}"
git push deploy HEAD:gh-pages