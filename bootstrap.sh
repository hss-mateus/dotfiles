#!/bin/sh

git pull origin master;

rsync --exclude ".git/" \
      --exclude "bootstrap.sh" \
      -avh . ~;
