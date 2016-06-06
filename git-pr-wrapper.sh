#!/bin/bash

git_command=git
pr_wrapper_version=0.1.0

# Use hub if it exists
which hub &> /dev/null
if [ "$?" -eq "0" ]; then
	git_command=hub
fi

gitPrWrapper() {
  # Handle git update-pull-request
  if [ "$1" = "update-pull-request" ]; then
    git_branch=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    erl=$?
    if [ "$erl" -neq "0" ]; then
      echo "git returned with status code $erl"
      return $erl
    fi

    if [ "$git_branch" == "master" ]; then
      if [ "$2" != "" ]; then
        git_branch=$2
      else
        echo "You need to specify the branch you want to push"
        echo "$0 $1 <branch_name>"
        return 1
      fi
    fi

    echo "Rebasing branch $git_branch onto master..."
    git rebase master $git_branch

    erl=$?
    if [ "$erl" -neq "0" ]; then
      echo "Rebase failed with status code $erl"
      echo "Fix merge conflicts and then try again"
      return $erl
    fi

    echo "Pushing branch to GitHub..."
    git push origin -f $git_branch
    return $?
  fi

  if [ "$1" == "version" ]; then
    $git_command version
    erl=$?
    echo "pr-wrapper version $pr_wrapper_version"
    return $erl
  else
    $git_command $@
  fi
}

alias git=gitPrWrapper

# If not sourced, display the version and git command used
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && echo "Configured pr-wrapper $pr_wrapper_version, using $git_command as git command"
