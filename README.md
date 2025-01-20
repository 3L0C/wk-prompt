# wk-prompt 

```
WK-PROMPT(1)                General Commands Manual                WK-PROMPT(1)

NAME
       wk-prompt - Shell scripting aide for wk(1).

SYNOPSIS
       source wk-prompt ; wk_prompt "$@" # or some other list

DESCRIPTION
       wk-prompt  is  a  tool for building wk menus from a list of options.  It
       provides customization of wk through ENVIRONMENT VARIABLES  to  get  the
       desired look and feel.  This is not a script in and of itself, it should
       be sourced by other bash(1) scripts.

ENVIRONMENT VARIABLES
       wk_keys
              wk_keys  is  a bash array of wk trigger keys to map to the prompt
              options.  By default this is (a s d f g h j k l ;) i.e.  the  QW‐
              ERTY home row keys.

       wk_nextkey
              wk_nextkey  is a wk trigger key to go to the next set of options,
              if any.  By default this is 'C-n' (CTRL+n).

       wk_prevkey
              wk_prevkey is a wk trigger key to go to the previous set  of  op‐
              tions, if any.  By default this is 'C-p' (CTRL+p).

       wk_cmdprefix
              wk_cmdprefix is the prefix that surrounds a command.  By default,
              this  is  '{{'.   If  the command contains closing braces ('}}'),
              then this should be modified accordingly.  See wks(5), DELIMITER,
              for more info.

       wk_cmdsuffix
              wk_cmdsuffix is the suffix that surrounds a command.  By default,
              this is '}}'.  If the command  contains  closing  braces  ('}}'),
              then this should be modified accordingly.  See wks(5), DELIMITER,
              for more info.

       wk_keywords
              wk_keywords  is  a bash array of hooks and flags to give to every
              wks key chord.  The default is an empty array.

       wk_preprocessorcmds
              wk_preprocessorcmds is a bash array with any desired preprocessor
              commands for the wks script.  The default is an empty array.

       build_wksdescription
              build_wksdescription is a bash function which takes in one  argu‐
              ment  and prints a description.  The argument is an item from the
              wk_options array.  By default the argument is returned unchanged.
              This function may be redefined to get the desired description for
              each option.

EXAMPLE
       A basic example might be something like this 'wk-prompt-test' script:

              #!/usr/bin/env bash

              source wk-prompt # must be in your $PATH

              wk_preprocessor_cmds=(":delay 0") # set delay to 0
              wk_keywords=("+write") # write all commands
              wk_prompt "$@"

       Such a script could be called like so:

              # {0..n} expands to the numbers between 0 and n.
              $ wk-prompt-test {01..30}

       The 'wk-prompt-test' script would give a wk menu with options 01 through
       30 and write the selected option to stdout, if any.

       A more useful example might be  something  like  this  'wk-video-prompt'
       script:

              #!/usr/bin/env bash

              source wk-prompt # must be in your PATH

              wk_preprocessor_cmds=(":delay 0") # set delay to 0
              wk_keywords=("+write") # write all commands

              build_wks_description() {
                  echo "${1##*/}" # trim everything but the file name
              }

              # Read files in the playlist into a videos array
              readarray -t videos <"playlist.m3u"

              # A similar example where the videos are given by some command
              # readarray -t videos < <(echo "/path/to/videos/"*)

              # Pass the videos to wk_prompt and get the user selection
              selection="$(wk_prompt "${videos[@]}")"

              # If a video was selected, play it with mpv
              [[ -n "$selection" ]] && mpv "$selection"

       Such  a  script  would  give  the  user  a  prompt  with  the  files  in
       "playlist.m3u" and play the selected file back using mpv.   There  is  a
       bit  more  going on here, but really not much has changed other than how
       the options and descriptions are generated.

BUG REPORTS
       If   you   find    a    bug    in    wk,    please    report    it    at
       ⟨https://github.com/3L0C/wk-prompt⟩.

SEE ALSO
       wk(1), wks(5), and bash(1)

```

