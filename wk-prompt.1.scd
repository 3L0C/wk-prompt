wk-prompt(1)

# NAME

wk-prompt - Shell scripting aide for *wk*(1).

# SYNOPSIS

*source wk-prompt ; wk_prompt "$@"* # or some other list

# DESCRIPTION

*wk-prompt* is a tool for building wk menus from a list of options. It provides
customization of wk through *ENVIRONMENT VARIABLES* to get the desired look and
feel. This is not a script in and of itself, it should be sourced by other
*bash*(1) scripts.

# ENVIRONMENT VARIABLES

*wk_keys*
	A bash array of wk trigger keys to map to the prompt options. By default
	this is _(a s d f g h j k l ;)_ i.e. the QWERTY home row keys.

*wk_show_title*
	Controls whether "Page X of Y" titles are shown. Set to any non-empty
	value to enable (default), or empty string to disable. Example:
	_wk_show_title=_ to disable titles.

*wk_next_key*
	A wk trigger key to go to the next set of options, if any. By default
	this is _C-n_ (*CTRL+n*).

*wk_prev_key*
	A wk trigger key to go to the previous set of options, if any. By default
	this is _C-p_ (*CTRL+p*).

*wk_cmd_prefix*
	The prefix that surrounds a command. By default, this is _{{_. If the
	command contains closing braces (_}}_), then this should be modified
	accordingly. See *wks*(5), *DELIMITER*, for more info.

*wk_cmd_suffix*
	The suffix that surrounds a command. By default, this is _}}_. If the
	command contains closing braces (_}}_), then this should be modified
	accordingly. See *wks*(5), *DELIMITER*, for more info.

*wk_keywords*
	A bash array of hooks and flags to give to every wks key chord. The
	default is an empty array.

*wk_preprocessor_cmds*
	A bash array with any desired preprocessor commands for the wks script.
	The default is an empty array.

*build_wks_description*
	A bash function which takes in one argument and prints a description. The
	argument is an item from the wk_options array. By default the argument is
	returned unchanged. This function may be redefined to get the desired
	description for each option.

# EXAMPLES

A basic example might be something like this _wk-prompt-test_ script:

```
#!/usr/bin/env bash

source wk-prompt # must be in your $PATH

wk_preprocessor_cmds=(":delay 0") # set delay to 0
wk_keywords=("+write") # write all commands
wk_prompt "$@"
```

Such a script could be called like so:

```
# {0..n} expands to the numbers between 0 and n.
$ wk-prompt-test {01..30}
```

The _wk-prompt-test_ script would give a wk menu with options 01 through 30 and
write the selected option to stdout, if any.

A more useful example might be something like this _wk-video-prompt_ script:

```
#!/usr/bin/env bash

source wk-prompt # must be in your PATH

wk_preprocessor_cmds=(":delay 0") # set delay to 0
wk_keywords=("+write") # write all commands

build_wks_description() {
    echo "${1##*/}" # trim everything but the file name
}

# Read files in the playlist into a videos array
readarray -t videos <"playlist.m3u"

# Pass the videos to wk_prompt and get the user selection
selection="$(wk_prompt "${videos[@]}")"

# If a video was selected, play it with mpv
[[ -n "$selection" ]] && mpv "$selection"
```

Such a script would give the user a prompt with the files in _playlist.m3u_ and
play the selected file back using mpv.

# BUG REPORTS

If you find a bug in *wk-prompt*, please report it at
https://github.com/3L0C/wk-prompt.

# SEE ALSO

*wk*(1), *wks*(5), *bash*(1)

# AUTHORS

3L0C <dotbox at mailbox.org>
