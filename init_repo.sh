#!/bin/sh
echo "# ti" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/odvieira/ti.git
git push -u origin master
