#-------------------------------------------------------------------------------
# DCD completion.
#-------------------------------------------------------------------------------
_dcd() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local suggestions
  for dir in $(_dcd_dirs $(_dversion $drupal_root)); do
    [ -d $drupal_root/$dir ] && suggestions="$suggestions "$(find $drupal_root/$dir -maxdepth 1 -type d -name '[^.]*' -exec basename {} \;)
  done

  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dcd dcd

#-------------------------------------------------------------------------------
# DL completion.
#-------------------------------------------------------------------------------
_dl() {
  COMPREPLY=()

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local drupal_version=$(_dversion $drupal_root)

  local suggestions  
  if [ -f $HOME/.drupal-projects/d$drupal_version.txt ]; then
      suggestions=$(cat $HOME/.drupal-projects/d$drupal_version.txt)
  elif [ -f /usr/share/drupal-projects/d$drupal_version.txt ]; then
      suggestions=$(cat /usr/share/drupal-projects/d$drupal_version.txt)
  else  
    return 1
  fi

  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dl dl

#-------------------------------------------------------------------------------
# DCONF completion.
#-------------------------------------------------------------------------------
_dconf() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local suggestions=$(find $drupal_root/sites/default -maxdepth 1 -type f -exec basename {} \;)

  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dconf dconf

#-------------------------------------------------------------------------------
# DBIN completion.
#-------------------------------------------------------------------------------
_dbin() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local suggestions=$(find $(_dvendor $drupal_root)/bin -mindepth 1 -maxdepth 1 -executable -exec basename {} \;)
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dbin dbin

#-------------------------------------------------------------------------------
# DTEST completion.
#-------------------------------------------------------------------------------
_dtest() {
  COMPREPLY=()

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local cur="${COMP_WORDS[COMP_CWORD]}"
  local suggestions
  local file=$drupal_root/$([ $(_dversion $drupal_root) = 8 ] && echo 'core/')scripts/run-tests.sh

  # Options.
  if [ "${cur:0:1}" = '-' ];then
    suggestions=$(php $file --help | grep -oE ' --[a-z-]+')
  # Groups.
  else
    suggestions=$(php $file --list | grep -vE '([- ]|^$)')
  fi

  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -F _dtest dtest


#-------------------------------------------------------------------------------
# DUNIT completion.
#-------------------------------------------------------------------------------
_dunit() {
  COMPREPLY=()

  local drupal_root=$(droot)
  if [ -z "$drupal_root" ]; then
    return 1
  fi

  local file=$(_dvendor $drupal_root)/bin/phpunit
  if [ ! -f $file ]; then
    return 1
  fi

  local cur="${COMP_WORDS[COMP_CWORD]}"
  # Only options can be completed.
  if [ "${cur:0:1}" != '-' ];then
    return 0
  fi

  local suggestions=$($file --help | grep -oE ' --[a-z-]+')
  COMPREPLY=( $(compgen -W "${suggestions}" -- ${cur}) )
}
complete -fF _dunit dunit
