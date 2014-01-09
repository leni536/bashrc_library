#!/bin/bash

# header guard
[ -n "$_STACK_H" ] && return || readonly _STACK_H=1

__clean()
{
	rm -rf "$_STACK_DIR"
	exit 0
}

trap __clean SIGHUP SIGINT SIGTERM EXIT

_STACK_DIR=`mktemp -d`

__stack_new()
{
	# $1 stack name
	test -z "$1" && return 1
	test -e "$_STACK_DIR/$1" && return 2
	touch "$_STACK_DIR/$1"
	return 0
}

__stack_del()
{
	# $1 name
	test -z "$1" && return 1
	if [ -e "$_STACK_DIR/$1" ]; then
		rm "$_STACK_DIR/$1"
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
	test -e "$_STACK_DIR/$1" || return 2
	echo "$2" >> "$_STACK_DIR/$1"
	return 0
}

__stack_pop()
{
	test -z "$1" && return 1
	test -e "$_STACK_DIR/$1" || return 2
	test "`wc -l < "$_STACK_DIR/$1"`" -eq 0 && return 3
	tail -1 "$_STACK_DIR/$1"
	sed -i -e '$d' "$_STACK_DIR/$1" 
}

__stack_clear()
{
	test -z "$1" && return 1
	test -e "$_STACK_DIR/$1" || return 2
	echo "" > "$_STACK_DIR/$1"
}
