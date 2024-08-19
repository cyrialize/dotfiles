#!/usr/bin/env bash

source $HOME/Code/dotfiles/lib/functions.sh

shopt -s nullglob

help=$(cat <<EOF
Sets up a new project based on templates in "project_templates".

Usage:
-c project choice, matches a folder name in "project_templates"
-p path to set up project
EOF
)

while getopts 'hc:p:' OPTION; do
  case "$OPTION" in
    c)
      language="$OPTARG"
      ;;
    p)
      path="$OPTARG"
      ;;
    h)
      echo "$help"
      exit 0
      ;;
    ?)
      echo "$help"
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

if [[ -z "$language" || -z "$path" ]]; then
  echo "$help"
  exit 1
fi

templates=()
langs=()
for dir in $HOME/Code/dotfiles/lib/project_templates/*; do
  templates+=("$dir")
  langs+=("$(basename $dir)")
done

found=0
chosenTemplate=""
chosenLang=""
for dir in "${templates[@]}"; do
  if [[ "$(basename $dir)" == "$language" ]]; then
    found=1
    chosenTemplate=$dir
    chosenLang=$(basename $dir)
    break
  fi
done

if [[ $found -eq 0 ]]; then
  print_color "red" "$language does not have a template, current templates are:"
  for template in "${templates[@]}"; do
    echo $template
  done
  exit 1
fi

parent_dir=$(dirname "$path")
if [[ ! -d "$parent_dir" ]]; then
  print_color "red" "$parent_dir is not a valid path, or does not exist"
  exit 1
fi

if [[ -e "$path" ]]; then
  print_color "red" "$path already exists!"
  exit 1
fi

echo
echo "-------------------------------------------------------------------------"
echo "Language:       $chosenLang"
echo "Template Path:  $chosenTemplate"
echo "Install Path:   $path"
echo "-------------------------------------------------------------------------"
echo
echo "continue?(y/n)"
read continue

if [[ "$continue" != "y" ]]; then
  exit 0
fi

print_color "yellow" "Attempting to create directory $path"
mkdir $path
log_result "Creating $path" "$?"
echo

print_color "yellow" "Attempting to copy $chosenTemplate into $path"
cp -r $chosenTemplate/. $path/
log_result "Copied $chosenTemplate into $path!" "$?"
echo

if [[ -e "$path" ]]; then
  print_color "green" "Successfully copied $chosenTemplate into $path"
  ls -la $path
  echo
fi
