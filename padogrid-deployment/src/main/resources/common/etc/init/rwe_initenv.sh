#!/usr/bin/env bash
SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
. $SCRIPT_DIR/setenv.sh

#
# IMPORTANT: Do NOT modify this file.
#

#
#  Set the default environment variable for this RWE.
#
RWE_DIR="$PADOGRID_WORKSPACES_HOME/.rwe"
DEFAULTENV_FILE="$RWE_DIR/defaultenv.sh"
if [ -f "$DEFAULTENV_FILE" ]; then
   . "$DEFAULTENV_FILE"
fi

# JAVA_DIR used for comparison
JAVA_DIR=$(dirname "$(which java)")

#
# Remove the previous paths from PATH to prevent duplicates
#
CLEANED_PATH=""
__IFS=$IFS
IFS=":"
PATH_ARRAY=($PATH)
for i in "${PATH_ARRAY[@]}"; do
   if [[ "$i" == "$JAVA_DIR"** ]] && [ "$JAVA_HOME" != "" ]; then
      continue;
   elif [[ "$i" == **"padogrid_"** ]] && [[ "$i" == **"bin_sh"** ]]; then
      continue;
   elif [[ "$i" == "$PRODUCT_HOME"** ]]; then
      continue;
   fi
      if [ "$CLEANED_PATH" == "" ]; then
          CLEANED_PATH="$i"
      else
         CLEANED_PATH="$CLEANED_PATH:$i" 
      fi
done
IFS=$__IFS

# Export cleaned PATH
export PATH="$CLEANED_PATH"

#
# Initialize auto completion
#
. $PADOGRID_HOME/$PRODUCT/bin_sh/.${PRODUCT}_completion.bash

#
# Display initialization info
#
if [ "$1" == "" ] || [ "$1" != "-quiet" ]; then
      echo ""
      echo "Workspaces Home:"
      echo "   PADOGRID_WORKSPACES_HOME=$PADOGRID_WORKSPACES_HOME"
      echo "Workspace:"
      echo "   PADOGRID_WORKSPACE=$PADOGRID_WORKSPACE"
      echo ""
      echo "All of your padogrid operations will be recorded in the workspace directory."
      echo ""
fi
