#!/bin/sh

bold=$(tput bold)
normal="\e[0m$(tput sgr0)"
green="\e[32m"
red="\e[31m"
yellow="\e[33m"
info="$bold$green=>$normal"
error="$bold${red}Error: $normal"
warning="$bold${yellow}Warning: $normal"

echo -e "$info Downloading js extension"
rm -f Extensions/dribbblish.js

if ! wget --quiet --show-progress -c -P Extensions "https://raw.githubusercontent.com/spicetify/spicetify-themes/master/Dribbblish/dribbblish.js"; then
  echo -e "\t$error Download of dribbblish.js failed!"
  exit 1
fi

echo -e "$info Downloading use.css"
rm -f Themes/Dribbblish/user.css
if ! wget --quiet --show-progress -c -P Themes/Dribbblish "https://raw.githubusercontent.com/spicetify/spicetify-themes/master/Dribbblish/user.css"; then
  echo -e "\t$error Download of use.css failed!"
  exit 1
fi

echo -e "$info Apply updates to Spotify"
spicetify config extensions dribbblish.js
spicetify config current_theme Dribbblish color_scheme nord-dark
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
spicetify apply
