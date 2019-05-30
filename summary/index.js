#!/usr/bin/env node

'use strict';

const { exec } = require('child_process')
const moment = require('moment')

let command = 'timew export today'

if (process.argv.length > 2) {
  let date = process.argv[2]
  let nextDate = moment(date).add(1, "days").format("YYYY-MM-DD")
  command = `timew export from ${date} to ${nextDate}`
}

exec(command, (err, stdout, stderr) => {
  if (err) {
    console.err(stderr)
    return
  }

  let projects = {}

  let timesheet = JSON.parse(stdout)
  for(let entry of timesheet) {
    let title = entry.tags ? entry.tags.join(" ") : "NO TAGS"
    projects[title] = projects[title] ? projects[title] : { total: 0, tags: entry.tags }

    projects[title].total += moment(entry.end).diff(moment(entry.start))
  }

  let totalTime = moment.duration()

  for (let title in projects) {
    if (title === "Lunch" || title === "lunch") continue
    let project = projects[title]
    let time = moment.duration(project.total)
    totalTime.add(time)
    console.log(`\n## ${title} - ${time.hours()}h ${time.minutes()}m`)
  }

  console.log(`\n_Total time (not including lunch): ${totalTime.hours()}h ${totalTime.minutes()}m_`)
})
