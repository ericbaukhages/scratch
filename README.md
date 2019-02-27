# scratch

My quick and dirty note, task, and time recorder. Inspired by some post somewhere online that I don't remember.

## Install

1. `mkdir ~/.scratch`
2. `cp template.md ~/.scratch`
3. Add the following to your `.bashrc` or `.zshrc`:

```
alias scratch="~/Downloads/personal/scratch/write.sh"
alias scratchtime="~/Downloads/personal/scratch/time.sh"
```

4. Profit!

## Usage

`scratch` opens a Markdown file within `~/.scratch` for the current day, creating the file if it doesn't already exist. This file uses the template found at `~/.scratch/template.md`.

`scratchtime` requires you to follow below example format. It will read the headers, e.g. `## Task name - more info - 9:00 am to 10:00 am`, and collect time spent for each one, tallying it into a total for the day.

## Example Document

```
# ============= TASKS =============

# ============= NOTES =============

## Meeting - 9:00 am to 10:00 am

## Email - 10:00 am to 10:15 am

## Coding - 10:15 am to 12:00 pm

## Lunch - 12:00 pm to 1:00 pm
```
