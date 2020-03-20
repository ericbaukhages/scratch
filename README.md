# scratch

My quick and dirty note recorder. Inspired by some post somewhere online that I don't remember.

## Install

1. `mkdir ~/.scratch`
2. `cp template.md ~/.scratch`
3. Add the following to your `.bashrc` or `.zshrc`:

```
alias scratch="~/Downloads/personal/scratch/write.sh"
```

4. Profit!

## Usage

`scratch` opens a Markdown file within `~/.scratch` for the current day, creating the file if it doesn't already exist. This file uses the template found at `~/.scratch/template.md`.

## Example Document

```
# ============= NOTES =============

## 09:45AM

Something cool happened today.

## 01:13PM

Had a really cool lunch.

```
