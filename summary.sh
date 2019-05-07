#!/bin/bash

SCRATCH_DIR=~/.scratch

SCRATCH_PREV_DIR=`pwd`
SCRIPT_DIR=`dirname $0`
TEMPLATE_DIR=$SCRIPT_DIR/templates

cd $SCRATCH_DIR

ENTRY="`date +"%Y-%m-%d"`.md"

# Save the summary headers to a temporary file
SUMMARY=`mktemp`
$SCRIPT_DIR/summary/index.js > $SUMMARY

if [ -f $ENTRY ]; then
  grep -q "SUMMARY" $ENTRY
  if [ $? -eq 1 ]; then
    vim $ENTRY +"normal G" +"r $TEMPLATE_DIR/summary.md" \
      +"normal G" +"r $SUMMARY" +"normal G" && cd $SCRATCH_PREV_DIR
  else
    vim $ENTRY && cd $SCRATCH_PREV_DIR
  fi
else
  vim +"r $TEMPLATE_DIR/notes.md" +"normal G" \
    +"r $TEMPLATE_DIR/summary.md" +"normal G" \
    +"r $SUMMARY" $ENTRY && cd $SCRATCH_PREV_DIR
fi
