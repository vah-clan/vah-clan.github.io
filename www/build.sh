#!/bin/bash

work_dir[0]="./"
work_dir[1]="./blg/"

# main()
#
# Parse the command line parameters and perform some function based on that
# requirement.
#
# @param $@ All of the command line parameters.
function main {
  # Parse command line parameters
  case $1 in
    -b|--build)
      build
      ;;
    -c|--clean)
      clean
      ;;
    -h|--help)
      help
      ;;
    *)
      error "Unknown command, type '-h' for help."
      ;;
  esac
}

# build()
#
# Build the website files for static viewing.
function build {
  for i in "${work_dir[@]}"; do
    # Pre-compile the inclusion markdown files
    for z in $i*.markdown; do
      pandoc $z -o ${z%.*}.html
    done
    # Build markdown files
    for z in $i*.md; do
      pandoc -s -c $(pwd)/style.css -B $(pwd)/header.html $z -o ${z%.*}.html
    done
  done
}

# clean()
#
# Remove the build files from the directories.
function clean {
  for i in "${work_dir[@]}"; do
    rm *.html
  done
}

# help()
#
# Display the program help.
function help {
  echo "  build.sh [OPT]"
  echo ""
  echo "    OPTions"
  echo ""
  echo "      -b  --build    Build the website"
  echo "      -c  --clean    Clean the build files"
  echo "      -h  --help     Display this help"
}

# error()
#
# Display an error message and quit the script.
#
# @param $1 The message to be displayed.
function error {
  echo "[!!] $1"
  exit
}

main $@
