export PYTHONPATH=/Library/Frameworks/Python.framework/Versions/2.5/lib/python2.5/site-packages/

# Aliases for common commands with flags
alias gs='git status -u'
alias hs='hg status -q'

# Let me run up to 256 processes
ulimit -u 256


# don't put duplicate lines in the history. See bash(1) for more options
# ... and ignore same sucessive entries.
# This has the downside that it's no longer possible to track the frequency of commands
# as described here: http://matt.might.net/articles/console-hacks-exploiting-frequency/
export HISTCONTROL=ignoreboth

# set the time format for the history file.
export HISTTIMEFORMAT="%Y.%m.%d %H:%M:%S "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
  # Show the currently running command in the terminal title:
  # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
  show_command_in_title_bar()
  {
    case "$BASH_COMMAND" in
      *\033]0*)
      # The command is trying to set the title bar as well;
      # this is most likely the execution of $PROMPT_COMMAND.
      # In any case nested escapes confuse the terminal, so don't
      # output them.
      ;;
      *)
      if test ! "$BASH_COMMAND" = "log_bash_eternal_history"
      then
        echo -ne "\033]0;$(history 1 | sed 's/^ *[0-9]* *//') :: ${PWD} :: ${USER}@${HOSTNAME}\007"
      fi
      ;;
    esac
  }
  trap show_command_in_title_bar DEBUG
  ;;
  *)
  ;;
esac

log_bash_eternal_history()
{
  command=$(history 1)
  if [ "$LOG_BASH_ETERNAL_HISTORY" ]
  then
    if [ "$command" ]
    then
      date_part=`echo $command | sed 's/^ *[0-9]* \([0-9\.]* [0-9:]*\).*/\1/'`
      command_part=`echo $command | sed 's/^ *[0-9]* [0-9\.]* [0-9:]* \(.*\)/\1/'`
      if [ "$command_part" != "$LOG_BASH_ETERNAL_HISTORY" -a "$command_part" != "ls" ]
      then
        echo $date_part $USER@$HOSTNAME $? $command_part >> ~/.bash_eternal_history
        export LOG_BASH_ETERNAL_HISTORY="$command_part"
      fi
    fi
  else
    export LOG_BASH_ETERNAL_HISTORY="LOG_BASH_ETERNAL_HISTORY_INITIALIZATION"
  fi
}

PROMPT_COMMAND="log_bash_eternal_history"
