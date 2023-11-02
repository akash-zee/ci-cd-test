#! /bin/bash
set -e

REPO_HOST=$1
REPO_TYPE=$2
REPO_SSH_USER=$3
REPO_SSH_PASS=$4
PACKAGE_NAME=$5

increment_patch() {
  local version="$1"
  local major minor patch

  # Split the version into major, minor, and patch
  IFS='.' read -r major minor patch <<< "$version"

  # Increment the patch version
  ((patch++))

  # Assemble the new version
  local new_version="$major.$minor.$patch"
  
  echo "$new_version"
}

echo "Getting latest version of $PACKAGE_NAME from repo01"
CURR_VERSION=$(sshpass -p $REPO_SSH_PASS ssh -o StrictHostKeyChecking=no $REPO_SSH_USER@$REPO_HOST "aptly package search 'Name ($PACKAGE_NAME), Architecture (all)' | head -n 1 | awk '{split(\$1,a,\"_\"); print(a[2])}'")

if [ -z "$CURR_VERSION" ]; then
  NEW_VERSION='3.0.0'
else
  NEW_VERSION=$(increment_patch "$CURR_VERSION")
fi

echo "Current: $CURR_VERSION, New: $NEW_VERSION"

echo "Updating version: $NEW_VERSION in deb-build/DEBIAN/control"
sed -i "s/Version:.*/Version: $NEW_VERSION/g" deb-build/DEBIAN/control

echo "Update version completed"
