#!/bin/bash

SCRATCH_DIR=~/.scratch

SCRATCH_PREV_DIR=`pwd`
SCRIPT_DIR=`dirname $0`
TEMPLATE_DIR=$SCRIPT_DIR/templates

cd $SCRATCH_DIR

if [[ "$#" -eq 1 ]]; then
  DATE="$1"
else
  DATE="`date +"%Y-%m-%d"`"
fi

FILENAME="$DATE.md"

if [[ ! -e $FILENAME ]]; then
  echo "No record found for $DATE"
  exit 1
fi


# Save the summary headers to a temporary file
SUMMARY=`mktemp`
$SCRIPT_DIR/summary/index.js > $SUMMARY

if [ -f $FILENAME ]; then
  grep -q "SUMMARY" $FILENAME
  if [ $? -eq 1 ]; then
    vim $FILENAME +"normal G" +"r $TEMPLATE_DIR/summary.md" \
      +"normal G" +"r $SUMMARY" +"normal G" && cd $SCRATCH_PREV_DIR
  else
    vim $FILENAME && cd $SCRATCH_PREV_DIR
  fi
else
  vim +"r $TEMPLATE_DIR/notes.md" +"normal G" \
    +"r $TEMPLATE_DIR/summary.md" +"normal G" \
    +"r $SUMMARY" $FILENAME && cd $SCRATCH_PREV_DIR
fi
