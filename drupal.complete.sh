#-------------------------------------------------------------------------------
# DCD completion.
#-------------------------------------------------------------------------------
_complete_dcd() {
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
complete -F _complete_dcd dcd

#-------------------------------------------------------------------------------
# DL and DLE completion.
#-------------------------------------------------------------------------------
_complete_dl() {
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
complete -F _complete_dl dl
complete -F _complete_dl dle

#-------------------------------------------------------------------------------
# DCONF completion.
#-------------------------------------------------------------------------------
_complete_dconf() {
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
complete -F _complete_dconf dconf

#-------------------------------------------------------------------------------
# DBIN completion.
#-------------------------------------------------------------------------------
_complete_dbin() {
  COMPREPLY=()

  # Complete only fist argument.
  if [ "$COMP_CWORD" -gt 1 ]; then
    return
  fi

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local BIN_DIR=$(_dbin $DRUPAL_ROOT)
  if [ -z "$BIN_DIR" ]; then
    return 1
  fi

  local SUGGESTIONS=$(find $BIN_DIR -mindepth 1 -maxdepth 1 -executable -exec basename {} \;)
  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "${SUGGESTIONS}" -- ${CUR}) )
}
complete -F _complete_dbin dbin

#-------------------------------------------------------------------------------
# DTEST completion.
#-------------------------------------------------------------------------------
_complete_dtest() {
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
complete -F _complete_dtest dtest

#-------------------------------------------------------------------------------
# DUNIT completion.
#-------------------------------------------------------------------------------
_complete_dunit() {
  COMPREPLY=()

  local DRUPAL_ROOT=$(droot)
  if [ -z "$DRUPAL_ROOT" ]; then
    return 1
  fi

  local FILE=$(_dbin $DRUPAL_ROOT)/phpunit
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
complete -fF _complete_dunit dunit
