#===============================================================================
# DrupalRC completions
#===============================================================================

# shellcheck disable=SC2155
# shellcheck disable=SC2207

#-------------------------------------------------------------------------------
# dcd completion.
#-------------------------------------------------------------------------------
_complete_dcd() {
  COMPREPLY=()

  # Complete only fist argument.
  if [[ $COMP_CWORD -gt 1 ]]; then
    return 0
  fi

  local DRUPAL_ROOT
  if ! DRUPAL_ROOT=$(droot); then
    return 1
  fi

  if [[ $(_dversion "$DRUPAL_ROOT") -lt 8 ]]; then
    return 1
  fi

  TARGET_DIRS="$DRUPAL_ROOT/core/modules $DRUPAL_ROOT/core/themes $DRUPAL_ROOT/modules $DRUPAL_ROOT/themes"
  # shellcheck disable=SC2086
  DIRS=$(find \
    $TARGET_DIRS \
    -maxdepth 4 \
    -path "*engines" -prune -o \
    -path "*js" -prune -o \
    -path "*css" -prune -o \
    -path "*tests" -prune -o \
    -path "*templates" -prune -o \
    -path "*config" -prune -o \
    -path "*src" -prune -o \
    -path "*.git" -prune -o \
    -name "*.info.yml"\
    -printf '%f\n')

  local SUGGESTIONS=$(_dcd_dirs)" "${DIRS//.info.yml}
  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$SUGGESTIONS" -- "$CUR") )
}
complete -o plusdirs -F _complete_dcd dcd

#-------------------------------------------------------------------------------
# dconf completion.
#-------------------------------------------------------------------------------
_complete_dconf() {
  COMPREPLY=()

  # Complete only fist argument.
  if [[ $COMP_CWORD -gt 1 ]]; then
    return 0
  fi

  local DRUPAL_ROOT
  if ! DRUPAL_ROOT=$(droot); then
    return 1
  fi

  local PROJECT_ROOT
  if ! PROJECT_ROOT=$(_dproject "$DRUPAL_ROOT"); then
    return 1
  fi

  local SUGGESTIONS=$(find "$DRUPAL_ROOT"/sites/default -maxdepth 1 -type f -printf '%f\n')
  if [[ -f $PROJECT_ROOT/composer.json ]]; then
    SUGGESTIONS="$SUGGESTIONS composer.json"
  fi

  if [[ -f $PROJECT_ROOT/package.json ]]; then
    SUGGESTIONS="$SUGGESTIONS package.json"
  fi

  if [[ -f $PROJECT_ROOT/phpcs.xml ]]; then
    SUGGESTIONS="$SUGGESTIONS phpcs.xml"
  fi

  if [[ -f $PROJECT_ROOT/phpunit.xml ]]; then
    SUGGESTIONS="$SUGGESTIONS phpunit.xml"
  fi
  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$SUGGESTIONS" -- "$CUR") )
}
complete -F _complete_dconf dconf

#-------------------------------------------------------------------------------
# dbin completion.
#-------------------------------------------------------------------------------
_complete_dbin() {
  COMPREPLY=()

  # Complete only fist argument.
  if [[ $COMP_CWORD -gt 1 ]]; then
    return
  fi

  local DRUPAL_ROOT
  if ! DRUPAL_ROOT=$(droot); then
    return 1;
  fi

  local BIN_DIR
  if ! BIN_DIR=$(_dbin "$DRUPAL_ROOT"); then
    return 1
  fi

  local SUGGESTIONS=$(find "$BIN_DIR" -mindepth 1 -maxdepth 1 -executable -printf '%f\n')
  local CUR="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$SUGGESTIONS" -- "$CUR") )
}
complete -o default -F _complete_dbin dbin

#-------------------------------------------------------------------------------
# dunit completion.
#-------------------------------------------------------------------------------
_complete_dunit() {
  COMPREPLY=()

  local DRUPAL_ROOT
  if ! DRUPAL_ROOT=$(droot); then
    return 1;
  fi

  local FILE=$(_dbin "$DRUPAL_ROOT")/phpunit

  if [[ ! -x $FILE ]]; then
    return 1
  fi

  local CUR="${COMP_WORDS[COMP_CWORD]}"
  # Only options can be completed.
  if [[ ${CUR:0:1} != '-' ]]; then
    return 0
  fi

  local SUGGESTIONS=$($FILE --help | grep -oE ' --[a-z-]+')
  COMPREPLY=( $(compgen -W "$SUGGESTIONS" -- "$CUR") )
}
complete -o default -F _complete_dunit dunit

#-------------------------------------------------------------------------------
# dcomposer completion.
#-------------------------------------------------------------------------------
complete -F _composer dcomposer