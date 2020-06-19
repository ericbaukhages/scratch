#!/bin/bash

if [ -z "$SCRATCH_DIR" ]; then
  SCRATCH_DIR=~/.scratch
fi

SCRATCH_PREV_DIR=`pwd`

cd $SCRATCH_DIR

if [[ "$#" -eq 1 ]]; then
  DATE="$1"
else
  DATE="`date +"%Y-%m-%d"`"
fi

FILENAME="$DATE.md"

ENTRY=`mktemp`
echo -e "## $(date +'%I:%M%p')\n" >> $ENTRY

if [ -f $FILENAME ]; then
  vim +"normal G" +"r $ENTRY" +"normal G" $FILENAME
else
  vim +"r $ENTRY" +"normal G" $FILENAME
fi

# Go back to previous directory
cd $SCRATCH_PREV_DIR
