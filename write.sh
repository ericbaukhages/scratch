#!/bin/bash

SCRATCH_DIR=~/.scratch

SCRATCH_PREV_DIR=`pwd`
SCRIPT_DIR=`dirname $0`
TEMPLATE_DIR=$SCRIPT_DIR/templates

cd $SCRATCH_DIR

FILENAME="`date +"%Y-%m-%d"`.md"

if [ -f $FILENAME ]; then
  vim $FILENAME && cd $SCRATCH_PREV_DIR
else
  vim +"r $TEMPLATE_DIR/notes.md" +"normal G" $FILENAME && cd $SCRATCH_PREV_DIR
fi
