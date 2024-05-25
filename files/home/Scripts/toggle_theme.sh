#!/usr/bin/env bash

msg() { echo -e "\n$1\n"; }

if [ $# -eq 0 ]; then
  msg "Usage: $(basename "$0") [dark|light] [--light-text|--dark-text]"
  exit 1
fi

for arg in "$@"; do
  case $arg in
    --light-text)
      dark_text=false
      shift
      ;;
    --dark-text)
      dark_text=true
      shift
      ;;
    *)
      theme=$arg
      ;;
  esac
done

case $theme in
  dark)
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme Yaru-dark
    gsettings set org.gnome.desktop.interface icon-theme Yaru-dark
    gsettings set org.gnome.shell.extensions.ding dark-text-in-labels ${dark_text:=false}
    ;;
  light)
    gsettings set org.gnome.desktop.interface color-scheme default
    gsettings set org.gnome.desktop.interface gtk-theme Yaru
    gsettings set org.gnome.desktop.interface icon-theme Yaru
    gsettings set org.gnome.shell.extensions.ding dark-text-in-labels ${dark_text:=true}
    ;;
  *)
    if [ -z "$1" ]; then
      msg "Missing argument. Use 'dark' or 'light'."
    else
      msg "Invalid argument $1. Use 'dark' or 'light' instead."
    fi
    exit 1
    ;;
esac

msg "Theme is set to ${theme}."

