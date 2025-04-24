#!/usr/bin/env sh
emacs -Q --script build-site.el
sudo cp -R ./public/* /var/www/
