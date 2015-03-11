#!/bin/sh

# set project home directory
Project_Home=~/dating

tmux new -d -c ${Project_Home} -s dating -n editor vim
tmux split-window -c ${Project_Home} -h -p 35 -t dating
tmux split-window -c ${Project_Home} -v -t dating
tmux new-window -c ~/ -n tmp -t dating
tmux select-window -l -t dating
tmux select-pane -L
tmux attach -t dating
