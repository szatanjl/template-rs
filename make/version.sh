#!/bin/sh -eu

DATEFMT='%Y-%m-%d %H:%M:%S'
export TZ=UTC0

git_describe()
{
	git describe --always --dirty --broken --first-parent \
		--match='v*.*.*' "$@"
}

version=$(git_describe)
revision=$(git_describe --long --abbrev=40)
date=$(git log -1 --format='%cd' --date="format-local:${DATEFMT}")

printf '%s' "\
VERSION = ${version}
REVISION = ${revision}
DATE = ${date}
"
