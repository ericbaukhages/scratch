#!/bin/bash

SCRATCH_DIR=~/.scratch

INPUT="$1"

if [[ "$#" -eq 1 ]]; then
  INPUT="$SCRATCH_DIR/$INPUT.md"
else
  INPUT="$SCRATCH_DIR/`ls -t $SCRATCH_DIR | head -n 1`"
fi

dateFromFile()
{
  basename $1 | sed 's/.md//g'
}

outputTime()
{
  timeInSeconds=$1

  hours=$(($timeInSeconds / 3600 ))
  minutes=$((($timeInSeconds % 3600) / 60))
  seconds=$(($timeInSeconds % 60 ))

  echo "${hours}h ${minutes}m ${seconds}s"
}

if [[ ! -e $INPUT ]]; then
  DATE=`dateFromFile $INPUT`
  echo "No record found for $DATE"
  exit 1
fi

echo "==== TIME ===="

totalSeconds=0
lunchSeconds=0

IFS=$'
'
for entry in `pandoc -t html $INPUT | pup 'h2 json{}' | jq '.[] | .text' -r`; do
  date=`echo $entry | sed 's/\(.*\) - \(.* [ap]m\) to \(.* [ap]m\)/{"title":"\1","start":"\2","end":"\3"}/g'`

  title=`echo $date | jq -r '.title' 2>/dev/null`
  start=`echo $date | jq -r '.start' 2>/dev/null`
  end=`echo $date | jq -r '.end' 2>/dev/null`

  [[ -z $title ]] && echo " - *** Skipping \"$entry\" ***" && continue

  startDate=`date -j -f "%I:%M %p" "$start" "+%s"`
  endDate=`date -j -f "%I:%M %p" "$end" "+%s"`

  diff=$(($endDate - $startDate)) 
  totalSeconds=$(($totalSeconds + $diff))

  if [[ $title == "Lunch" ]]; then
    lunchSeconds=$(($lunchSeconds + $diff))
  fi

  echo " - $title: `outputTime $diff`"
done
unset IFS

echo "==== TOTAL ===="
echo "Total time tracked for `dateFromFile $INPUT`: `outputTime $(($totalSeconds - $lunchSeconds))`"
echo "                  including LUNCH: `outputTime $totalSeconds`"
