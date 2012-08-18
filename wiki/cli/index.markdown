---
layout: wiki
---

[Tips](/wiki/cli/tips), some nice commands/apps.

Create a fifo pipe

    mkfifo

Create ssh key

    ssh-keygen -t rsa

Change to last dir

    cd -

Resolve current dir with respect to symlinks

    pwd -P

Output file backwards

    tac

Reorder lines

    shuf

Copy ssh keys to user@host to enable passwordless login

    ssh-copy-id user@host

Replace inline in file and backup

    sed -i.bak s/STRING_TO_REPLACE/STRING_TO_REPLACE_IT/g index.html

