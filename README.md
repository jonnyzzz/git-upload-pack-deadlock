Reproducing git-upload-pack hung
================================


Git upload-pack command hungs if tracing is enabled.

To reproduce the hund, do the following
* clone the repository with all branches and tags
* make sure all branches are there (via `git branch -r` command)
* make sure all tags are there (via `git tags` command)
* execute `./test.sh`


My experiments shown it's vital to have tags in the play.


It reproduces for most fresh git versions.


Investigation
==============

Based on 

    $ git --version
    git version 2.8.2.windows.1.1.g85fb4ba.dirty



I stuck around the deadlock inside git when running `git upload-pack .` command. A debugging shown that the 
bottom process (it starts several processes to implement the task) hangs writing to stderr. I managed to 
reproduce the issue with a tiny bash script. The repository and the script is found here in the repo.

I saw the issue reproducing both under Windows and Linux/Mac.

Windows thread dumps are available here 
https://github.com/jonnyzzz/git-upload-pack-deadlock/tree/master/debug


According to those thread dumps I see the following problem around `upload-pack.c` line 129. There the `pack_objects` 
command is executed. First the wants block is pushed to the command, next the stdout processing is started. 
This means, that `pack_objects` process output is not processed until all output is put there. In the case 
I have, the `pack_objects` process writes TRACE logging into stderr and eventually (on huge repository) the OS 
buffer runs-out deadlocking the execution. 
