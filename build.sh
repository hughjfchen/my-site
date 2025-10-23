#!/usr/bin/env bash

# update the content first
git pull

# build it
emacs -Q --script build-site.el

# now copy the built content to the web server
ORIG_OWNER=$(stat -c '%U:%G' /var/www/index.html)
sudo cp -R ./public/* /var/www/
sudo chown -R "$ORIG_OWNER" /var/www/*
