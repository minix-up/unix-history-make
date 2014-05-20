#!/bin/sh
#
# Import Unix branches into a single repo
#

# Location of archive mirror
OLD_UNIX=$UH/vol/nbk/old-unix

# Initialize repo
rm -rf import
mkdir import
cd import
git init
cp ../old-code-license LICENSE
git add LICENSE
git commit -a -m "Add license"

# Release branch
git branch Research-Release


cd ..
git branch Research-Development-v5
SHA=`cd import; git rev-parse Research-Release`
perl import-dir.pl -m $SHA -c v5.map $OLD_UNIX/v5 Research V5 -0500 |
more
exit
(cd import ; git fast-import --stats --done --quiet)

git branch Research-Development-v6
SHA=`cd import; git rev-parse Research-Release`
perl import-dir.pl -m $SHA -c v6.map $OLD_UNIX/v6 Research V6 -0500 |
(cd import ; git fast-import --stats --done --quiet)

#git repack --window=50 -a -d -f