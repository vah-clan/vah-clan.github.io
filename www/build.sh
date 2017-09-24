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
      rss
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
      pandoc -s -c /www/style.css -B $(pwd)/header.html $z -o ${z%.*}.html
    done
  done
}

# rss()
#
# Build a statically generated RSS feed.
function rss {
  rm vah.rss
  echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"   >> vah.rss
  echo "<rss version=\"2.0\">"                         >> vah.rss
  echo "  <channel>"                                   >> vah.rss
  echo "    <title>|VAH| Clan</title>"                 >> vah.rss
  echo "    <description>Blog updates</description>"   >> vah.rss
  echo "    <link>https://vah-clan.github.io</link>"   >> vah.rss
  echo "    <lastBuildDate>$(date -R)</lastBuildDate>" >> vah.rss
  echo "    <pubDate>$(date -R)</pubDate>"             >> vah.rss
  echo "    <ttl>1800</ttl>"                           >> vah.rss
  for z in blg/*.md; do
    title="$(sed '1q;d' $z)"
    description="$(sed '5q;d' $z)"
    link="https://vah-clan.github.io/www/${z%.*}.html"
    pubdate="$(date -r $z -R)"
    echo "    <item>"                                    >> vah.rss
    echo "      <title>$title</title>"                   >> vah.rss
    echo "      <description>$description</description>" >> vah.rss
    echo "      <link>$link</link>"                      >> vah.rss
    echo "      <pubDate>$pubdate</pubDate>"             >> vah.rss
    echo "    </item>"                                   >> vah.rss
  done
  echo "  </channel>"                                  >> vah.rss
  echo "</rss>"                                        >> vah.rss
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
