# git-pr-wrapper

Wraps git to add `git update-pull-request` which rebases the current branch and
pushes it to origin, so that updating pull requests is a single command.
Assumes the shell is `bash`.

## Installation

1. Clone this repository somewhere
2. Source it in your `.bash_profile` (eg. add a line that reads `. git-pr-wrapper.sh` in it)
3. Source `git-pr-wrapper.sh` to test it out in your current shell

```
$ . git-pr-wrapper.sh 
$ git version
git version 2.5.4 (Apple Git-61)
hub version 2.2.3
pr-wrapper version 0.0.1
```

## Usage

`git update-pull-request` in a branch, or `git update-pull-request <branch_name>` from master. Equivalent to `git rebase master $branch_name` followed by `git push origin $branch_name`.

## License

WTFPL.
