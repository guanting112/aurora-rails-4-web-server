#!/bin/bash

function run_script_install_rails()
{
  install_image_magick
  install_rails
}

function install_image_magick()
{
  echo "Install Image Magick and 'magickwand-dev' " | shell_log

  sudo apt-get install -y imagemagick libmagickwand-dev | shell_message "apt-get/image-magick"
}

function install_rails()
{
  local image_magick_is_installed=0

  [ "`which convert`" == '/usr/bin/convert' ] && image_magick_is_installed=1

  if [ $image_magick_is_installed == 1 ]
  then
    echo "Install Rails, Mailgun, Backup, Rest-Client " | shell_log
    gem install rails -v "~>4" 2>&1 | shell_message "gem(rails-4)"
    gem install rest-client mailgun backup whenever 2>&1 | shell_message "gem(s)"
  else
    echo "Rails needs to install imagemagick" | shell_error
  fi
}

run_script_install_rails