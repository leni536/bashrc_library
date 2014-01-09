#!/bin/bash

__clean()
{
	rm -rf "$STACKDIR"
	exit 0
}

trap __clean SIGHUP SIGINT SIGTERM EXIT

STACKDIR=`mktemp -d`

__stack_new()
{
	# $1 stack name
	test -z "$1" && return 1
	test -e "$STACKDIR/$1" && return 2
	touch "$STACKDIR/$1"
	return 0
}

__stack_del()
{
	# $1 name
	test -z "$1" && return 1
	if [ -e "$STACKDIR/$1" ]; then
		rm "$STACKDIR/$1"
	else
		return 2
	fi
	return 0
}

__stack_push()
{
	# $1 name
	# $2 line
	test -z "$1" -o -z "$2" && return 1
	test -e "$STACKDIR/$1" || return 2
	echo "$2" >> "$STACKDIR/$1"
	return 0
}

__stack_pop()
{
	test -z "$1" && return 1
	test -e "$STACKDIR/$1" || return 2
	test "`wc -l < "$STACKDIR/$1"`" -eq 0 && return 3
	tail -1 "$STACKDIR/$1"
	sed -i -e '$d' "$STACKDIR/$1" 
}

__stack_clear()
{
	test -z "$1" && return 1
	test -e "$STACKDIR/$1" || return 2
	echo "" > "$STACKDIR/$1"
}
