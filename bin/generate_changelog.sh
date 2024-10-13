#!/bin/sh

# Überschrift des Changelogs
echo "# Changelog" > CHANGELOG.md
echo "" >> CHANGELOG.md

# Loop über alle Tage, an denen Commits gemacht wurden
git log --date=short --pretty=format:"%ad" | sort -u | while read date; do
    echo "## $date" >> CHANGELOG.md
    echo "" >> CHANGELOG.md
    git log --pretty=format:"- %h %s" --date=short --since="$date 00:00" --until="$date 23:59" >> CHANGELOG.md
    echo "" >> CHANGELOG.md
done
