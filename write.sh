#!/bin/bash

SCRATCH_PREV_DIR=`pwd`
cd ~/.scratch

FILENAME="`date +"%Y-%m-%d"`.md"

if [ -f $FILENAME ]; then
  vim $FILENAME && cd $SCRATCH_PREV_DIR
else
  vim +"r template.md" $FILENAME && cd $SCRATCH_PREV_DIR
fi
