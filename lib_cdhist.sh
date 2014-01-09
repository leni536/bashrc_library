#!/bin/bash

source "$BASHSOURCEDIR/lib_stack.sh"

cd^()
{
	_CDHIST_PROMPT_FLAG="off"
	local updir
	updir=`__stack_pop cdup`
	if [ ! -z "$updir" ]; then
		__stack_push cddown "`pwd`"
		cd "$updir";
		_CDHIST_OLDDIR="$updir"
	fi
}

cd,()
{
	_CDHIST_PROMPT_FLAG="off"
	local downdir
	downdir=`__stack_pop cddown`
	if [ ! -z "$downdir" ]; then
		__stack_push cdup "`pwd`"
		cd "$downdir";
		_CD_HIST_OLDDIR="$downdir"
	fi
}

__cdhist_prompt()
{
	if [ "$_CDHIST_PROMPT_FLAG" == "on" ]; then
		_CDHIST_CURRDIR="`pwd`"
		if [[ "$_CDHIST_OLDDIR" != "$_CDHIST_CURRDIR" ]]; then
			__stack_push cdup "$_CDHIST_OLDDIR"
			__stack_clear cddown
			_CDHIST_OLDDIR="$_CDHIST_CURRDIR"
		fi
	else
		_CDHIST_PROMPT_FLAG=on
	fi
}

_CDHIST_OLDDIR="`pwd`"
_CDHIST_PROMPT_FLAG="on"

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} __cdhist_prompt "

__stack_new cdup
__stack_new cddown
