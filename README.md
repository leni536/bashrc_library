bashrc_library
==============
Installation
---------------
Copy the shell scripts into ~/.bash_source.

You need to append these lines to your ~/.bashrc file:
```bash
$BASHSOURCEDIR="$HOME/.bash_source"
for i in "$BASHSOURCEDIR"/*; do
    source "$i"
done
```
Usage
---------
There are currently one small utility, a prompt command and a stack implementation are in my source files.
### Stack implementation
>lib_stack.sh 

It's a really dumb stack implementation using temporary files, only accepting one-line datas.

Dependencies:

* sed

### Directory history
>lib_cdhist.sh

It introduces two simple commands, which allow directory navigation similar to browsers:

* cd^: back
* cd,: forward

Dependencies:

* lib_stack.sh (above)

###Interactive bash prompt
I merged this one from:

https://github.com/xtrementl/dev-bash-git-ps1
