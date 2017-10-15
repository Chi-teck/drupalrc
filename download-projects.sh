#!/bin/bash

mkdir drupal-projects

for PAGE in {0..99}; do
  echo PAGE $PAGE
  echo =========================================
  urls=$(curl -s https://www.drupal.org/project/usage?page=$PAGE | awk '/<td><a href="\/project/ { split($0, a, "\""); print "https://www.drupal.org/"a[4];}');
  for url in $urls; do
    HTML=$(curl -s $url);
    PROJECT=${url/*\// }
    if [ $PROJECT != drupal ]; then
      echo Checking $PROJECT...
      for i in {6,7,8}; do
        FOUND=$(echo "$HTML" | grep "<td class=\"active\"><a href=\"/project/usage/.*\">$i.x")
        if [ -n "$FOUND" ]; then
          echo $PROJECT >> drupal-projects/d$i.txt
        fi
      done
    fi
  done
done
