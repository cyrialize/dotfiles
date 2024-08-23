#!/usr/bin/env bash

find $HOME/Code/dotfiles -name '*.sh' -exec shellcheck {} +
result=$?

echo
echo "RESULT:"
echo "-----------------------"
if [[ $result -eq 0 ]]; then
  echo "All checks passed!"
else
  echo "Checks have failed!"
fi
echo "-----------------------"
echo
