#!/bin/bash

mkdir .drupal-projects

for page in {0..99}; do
  echo PAGE $page
  echo =========================================
  urls=$(curl -s https://www.drupal.org/project/usage?page=$page | awk '/<td><a href="\/project/ { split($0, a, "\""); print "https://www.drupal.org/"a[4];}');
  for url in $urls; do
    html=$(curl -s $url);
    project=${url/*\// }
    if [ $project != drupal ]; then
      echo Checking $project...
      for i in {6,7,8}; do
        found=$(echo "$html" | grep "<td class=\"active\"><a href=\"/project/usage/.*\">$i.x")
        if [ -n "$found" ]; then
          echo $project >> drupal-projects/d$i.txt
        fi
      done
    fi
  done
done
