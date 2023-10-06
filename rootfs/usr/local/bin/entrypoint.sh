#!/bin/ash
  if [ -z "${1}" ]; then
    pwsh
  fi

  exec "$@"