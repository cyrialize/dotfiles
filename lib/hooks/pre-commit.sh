#!/usr/bin/env bash

find "$HOME"/Code/dotfiles -name '*.sh' -exec shellcheck {} +
result=$?

if [[ $result -eq 0 ]]; then
  echo
  echo "All shellchecks passed!"
  exit 0
else
  echo
  echo "Shellchecks have failed!"
  exit 1
fi
