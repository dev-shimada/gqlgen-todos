#!/bin/bash
set -e

apt-get update && apt-get install -y vim git sqlite3 unzip

# tools
echo "source /usr/share/bash-completion/completions/git" >> ~/.bashrc
git config --local core.editor vim
git config --local pull.rebase false

# sample
go get -d github.com/99designs/gqlgen@v0.17.54
