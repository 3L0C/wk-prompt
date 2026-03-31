# wk-prompt 

```
wk-prompt(1)                General Commands Manual                wk-prompt(1)

NAME
       wk-prompt - Shell scripting aide for wk(1).

SYNOPSIS
       source wk-prompt ; wk_prompt "$@" # or some other list

DESCRIPTION
       wk-prompt  is  a  tool  for building wk menus from a list of options. It
       uses wk v0.2.0's @goto meta-command for flicker-free pagination. This is
       not a script in and of itself; it should be  sourced  by  other  bash(1)
       scripts to make building dynamic wk menus simple.

ENVIRONMENT VARIABLES
       wk_keys
           wk_keys  is a bash array of wk trigger keys to map to the prompt op‐
           tions. By default this is (a s d f g h j k l ;) i.e. the QWERTY home
           row keys. Must not be empty.

       wk_page_keys
           wk_page_keys is a read-only bash array of keys used for page naviga‐
           tion in the @goto tree. By default this is (0 1 2 3 4 5 6  7  8  9).
           The number of page keys determines the branching factor of the pagi‐
           nation tree.

       wk_prompt_title
           wk_prompt_title  is  a  string  used as a title prefix for paginated
           menus. When set alongside wk_show_page_numbers, the title appears as
           "TITLE - Page X of Y". When set alone, only the title is  shown.  By
           default this is an empty string (no title prefix).

       wk_show_page_numbers
           wk_show_page_numbers  controls whether "Page X of Y" is shown in the
           title. Set to any non-empty value  to  enable  (default),  or  empty
           string  to  disable.  Example: wk_show_page_numbers= to disable page
           numbers.

       wk_next_key
           wk_next_key is a wk trigger key to go to the next page. On the  last
           page,  this  cycles  back  to the first page. By default this is C-n
           (CTRL+n).

       wk_prev_key
           wk_prev_key is a wk trigger key to go to the previous page.  On  the
           first page, this cycles back to the last page. By default this is C-
           p (CTRL+p).

       wk_cmd_prefix
           wk_cmd_prefix  is  the  prefix that surrounds a command. By default,
           this is {{. If the command contains closing braces (}}),  then  this
           should  be  modified  accordingly.  See  wks(5), DELIMITER, for more
           info.

       wk_cmd_suffix
           wk_cmd_suffix is the suffix that surrounds a  command.  By  default,
           this  is  }}. If the command contains closing braces (}}), then this
           should be modified accordingly.  See  wks(5),  DELIMITER,  for  more
           info.

       wk_keywords
           wk_keywords  is a bash array of hooks and flags to give to every wks
           key chord. The default is an empty array.

       wk_preprocessor_cmds
           wk_preprocessor_cmds is a bash array with any  desired  preprocessor
           commands for the wks script. The default is an empty array.

       build_wks_description
           build_wks_description is a bash function which takes in one argument
           and sets the variable _wks_desc to a description. The argument is an
           item  from  the wk_options array. By default _wks_desc is set to the
           argument unchanged. This function may be redefined to  get  the  de‐
           sired  description  for  each  option.  Note:  the function must set
           _wks_desc rather than printing to stdout, to avoid subshell overhead
           on large option lists.

EXAMPLE
       A basic example might be something like this wk-prompt-test script:

           #!/usr/bin/env bash

           source wk-prompt # must be in your $PATH

           wk_preprocessor_cmds=(":delay 0") # set delay to 0
           wk_keywords=("+write") # write all commands
           wk_prompt "$@"

       Such a script could be called like so:

           # {0..n} expands to the numbers between 0 and n.
           $ wk-prompt-test {01..30}

       The wk-prompt-test script would give a wk menu with options  01  through
       30 and write the selected option to stdout, if any.

       A  more  useful  example  might  be  something like this wk-video-prompt
       script:

           #!/usr/bin/env bash

           source wk-prompt # must be in your PATH

           wk_preprocessor_cmds=(":delay 0") # set delay to 0
           wk_keywords=("+write") # write all commands

           build_wks_description() {
               _wks_desc="${1##*/}" # trim everything but the file name
           }

           # Read files in the playlist into a videos array
           readarray -t videos <"playlist.m3u"

           # Pass the videos to wk_prompt and get the user selection
           selection="$(wk_prompt "${videos[@]}")"

           # If a video was selected, play it with mpv
           [[ -n "$selection" ]] && mpv "$selection"

       Such  a  script  would  give  the  user  a  prompt  with  the  files  in
       playlist.m3u and play the selected file back using mpv.

BUG REPORTS
       If    you   find   a   bug   in   wk-prompt,   please   report   it   at
       https://github.com/3L0C/wk-prompt.

SEE ALSO
       wk(1), wks(5), bash(1)

AUTHORS
       3L0C <dotbox at mailbox.org>

                                   1980-01-01                      wk-prompt(1)
```

