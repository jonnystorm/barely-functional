# functional.sh - Curiously robust functional implementations for BASH
#
# Copyright © 2017 Jonathan Storm <jds@idio.link>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING.WTFPL file for more details.

_map()
{
  local fun=$1
  shift

  for e in "$@"; do
    echo "\"$(eval $fun $e)\""
  done
}

map()
{
  local fun=$1
  shift

  case $# in
    0)
      _map "$fun" $(cat)
      ;;
    *)
      _map "$fun" "$@"
      ;;
  esac
}

_reduce()
{
  local fun=$1
  local acc=$2
  shift
  shift

  for e in "$@"; do
    acc="\"$(eval "$fun $e $acc")\""
  done

  echo "$acc"
}

reduce(){
  local fun=$1
  local acc=$2
  shift
  shift

  case $# in
    0)
      _reduce "$fun" "'$acc'" $(cat)
      ;;
    1)
      _reduce "$fun" "'$acc'" "$1"
      ;;
    *)
      _reduce "$fun" "'$acc'" "$@"
      ;;
  esac
}

elem()
{
  local index=$1
  shift

  if [[ "$index" =~ [1-9][0-9]?[0-9]?[0-9]?[0-9]? ]]; then
    eval "echo \"\$$index\""
  fi
}

_filter()
{
  local fun=$1
  local value=$2
  local acc=$3

  (eval "$fun $value") &>/dev/null

  if [ $? -eq 0 ]; then
    echo "$value"
    echo "$acc"

  else
    echo "$acc"
  fi
}

filter()
{
  local fun=$1
  shift

  reduce "" "_filter $fun" "$@"
}
