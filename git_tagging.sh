#!/bin/bash
major_max=1;
minor_max=0;
# patch_max=0;
count=1
branch_name="develop"
change="minor"
last_tag=$(git describe --abbrev=0 --tags)
#last_second_tag=$(git describe --abbrev=1 --tags)
#last_second = $(git describe --abbrev=0 --tags $(`git rev-list --tags --max-count=1 --skip=1`))
echo 'last tag' $last_tag
if [[ $last_tag ]]; then
version=$(echo $last_tag | grep -o '[^-]*$')
    major=$(echo $version | cut -d. -f1)
    minor=$(echo $version | cut -d. -f2)
    # patch=$(echo $version | cut -d. -f3)
#if [ "$major_max" -lt "$major" ]; then
 #       let major_max=$major
 #   fi
echo 'major' $major
if [ "$change" == "major" ]; then
  echo "inside major"
  let major_max=`expr $major + $count`
  let minor_max=$minor_max
  # let patch_max=$patch_max
fi
echo 'minor' $minor
if [ "$change" == "minor" ]; then
  echo "inisde minor"
  let major_max=$major
  let minor_max=`expr $minor + $count`
  let patch_max=$patch
fi
echo 'majo_maxr'$minor_max
#if [ "$minor_max" -lt "$minor" ]; then
 #       let minor_max=$minor
  #  fi
#if [ "$patch_max" -lt "$patch" ]; then
 #       let patch_max=$patch
  #  fi
echo 'Latest version:' $major_max'.'$minor_max''
#let patch_max=($patch_max+1)
fi
#if [ "$major_max" -ne "${MAJOR_VERSION}" ] || [ "$minor_max" -ne "${MINOR_VERSION}" ]; then
 #   major_max="${MAJOR_VERSION}"
  #  minor_max="${MINOR_VERSION}"
   # patch_max=0
#fi
echo 'Switching to new version:' $major_max'.'$minor_max''
$(git tag -a $major_max.$minor_max $branch_name -m "Version $major_max.$minor_max")
echo 'Push tag to remote'
$(git push origin $major_max.$minor_max $branch_name)
