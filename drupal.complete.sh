#-------------------------------------------------------------------------------
# DCD completion.
#-------------------------------------------------------------------------------
_dcd() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local SUGGESTIONS
  for dir in $(_dcd_dirs $(_dversion $DRUPAL_ROOT)); do
    [ -d $DRUPAL_ROOT/$dir ] && SUGGESTIONS="$SUGGESTIONS "$(find $DRUPAL_ROOT/$dir -maxdepth 1 -type d -name '[^.]*' -exec basename {} \;)
  done

  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${SUGGESTIONS}" -- ${CUR}) )
}
complete -F _dcd dcd

#-------------------------------------------------------------------------------
# DL and DLE completion.
#-------------------------------------------------------------------------------
_dl() {
  COMPREPLY=()

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local DRUPAL_VERSION=$(_dversion $DRUPAL_ROOT)

  local SUGGESTIONS
  if [ -f $HOME/.drupal-projects/d$DRUPAL_VERSION.txt ]; then
      SUGGESTIONS=$(cat $HOME/.drupal-projects/d$DRUPAL_VERSION.txt)
  elif [ -f /usr/share/drupal-projects/d$DRUPAL_VERSION.txt ]; then
      SUGGESTIONS=$(cat /usr/share/drupal-projects/d$DRUPAL_VERSION.txt)
  else  
    return 1
  fi

  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${SUGGESTIONS}" -- ${CUR}) )
}
complete -F _dl dl
complete -F _dl dle

#-------------------------------------------------------------------------------
# DCONF completion.
#-------------------------------------------------------------------------------
_dconf() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local SUGGESTIONS=$(find $DRUPAL_ROOT/sites/default -maxdepth 1 -type f -exec basename {} \;)

  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${SUGGESTIONS}" -- ${CUR}) )
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

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local SUGGESTIONS=$(find $(_dvendor $DRUPAL_ROOT)/bin -mindepth 1 -maxdepth 1 -executable -exec basename {} \;)
  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${SUGGESTIONS}" -- ${CUR}) )
}
complete -F _dbin dbin

#-------------------------------------------------------------------------------
# DTEST completion.
#-------------------------------------------------------------------------------
_dtest() {
  COMPREPLY=()

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local CUR="${COMP_WORDS[COMP_CWORD]}"
  local SUGGESTIONS
  local FILE=$DRUPAL_ROOT/$([ $(_dversion $DRUPAL_ROOT) = 8 ] && echo 'core/')scripts/run-tests.sh

  # Options.
  if [ "${CUR:0:1}" = '-' ];then
    SUGGESTIONS=$(php $FILE --help | grep -oE ' --[a-z-]+')
  # Groups.
  else
    SUGGESTIONS=$(php $FILE --list | grep -vE '([- ]|^$)')
  fi

  COMPREPLY=( $(compgen -W "${SUGGESTIONS}" -- ${CUR}) )
}
complete -F _dtest dtest


#-------------------------------------------------------------------------------
# DUNIT completion.
#-------------------------------------------------------------------------------
_dunit() {
  COMPREPLY=()

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local FILE=$(_dvendor $DRUPAL_ROOT)/bin/phpunit
  if [ ! -f $FILE ]; then
    return 1
  fi

  local CUR="${COMP_WORDS[COMP_CWORD]}"
  # Only options can be completed.
  if [ "${CUR:0:1}" != '-' ];then
    return 0
  fi

  local SUGGESTIONS=$($FILE --help | grep -oE ' --[a-z-]+')
  COMPREPLY=( $(compgen -W "${SUGGESTIONS}" -- ${CUR}) )
}
complete -fF _dunit dunit
