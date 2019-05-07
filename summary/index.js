#!/usr/bin/env node

'use strict';

const { exec } = require('child_process')
const moment = require('moment')

let exportDate = process.argv.length > 2 ? process.argv[2] : "today"

exec(`timew export ${exportDate}`, (err, stdout, stderr) => {
  if (err) {
    console.err(stderr)
    return
  }

  let projects = {}

  let timesheet = JSON.parse(stdout)
  for(let entry of timesheet) {
    let title = entry.tags.join(" ")
    projects[title] = projects[title] ? projects[title] : { total: 0 }

    projects[title].total += moment(entry.end).diff(moment(entry.start))
  }

  for (let title in projects) {
    if (title === "Lunch" || title === "lunch") continue
    let project = projects[title]
    let time = moment.duration(project.total)
    console.log(`\n## ${title} - ${time.hours()}h ${time.minutes()}m`)
  }
})
