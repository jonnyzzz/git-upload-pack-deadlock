Reproducing git-upload-pack hung
================================


Git upload-pack command hungs if tracing is enabled.

To reproduce the hund, do the following
* clone the repository with all branches and tags
* make sure all branches are there (via `git branch -r` command)
* make sure all tags are there (via `git tags` command)
* execute `./test.sh`


My experiments shown it's vital to have tags in the play.
