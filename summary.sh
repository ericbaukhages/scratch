#!/bin/bash

SCRATCH_DIR=~/.scratch

SCRATCH_PREV_DIR=`pwd`
SCRIPT_DIR=`dirname $0`

cd $SCRATCH_DIR

FILENAME="`date +"%Y-%m-%d"`.md"

# Save the summary headers to a temporary file
TEMPHEADERS=`mktemp`
$SCRIPT_DIR/summary/index.js > $TEMPHEADERS

if [ -f $FILENAME ]; then
  vim $FILENAME && cd $SCRATCH_PREV_DIR
else
  vim +"r template.md" +"r $TEMPHEADERS" $FILENAME && cd $SCRATCH_PREV_DIR
fi
