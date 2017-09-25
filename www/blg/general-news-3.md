# General News

*By |VAH|-B[]*

We have decided to move some of our VAH servers to TM's master server in order
to encourage diversity within the game in light of some recent conversations.
Servers 3 and 4 have been moved, with servers 1 and 2 remaining on the master
server.

You can read more
[here](https://forum.cubers.net/thread-8875-post-172952.html#pid172952)
regarding the reasons behind the move, as well as opinions of others in the AC
community.

To change your script to start on TM's server, please change your script from:

    CUBE_OPTIONS="--home=${HOME}/.assaultcube_v1.2 --init -m164.132.110.143"

To:

    CUBE_OPTIONS="--home=${HOME}/.assaultcube_v1.2 --init -m164.132.110.143 \
      --masterport=28760 --mastertype=0"

It is easier if you have two scripts. This of course will look slightly
different depending on which OS you run, the above is for Linux. You will have
to find the equivalent for your OS, or use the
[EggCube Launcher](https://bitbucket.org/iguanameow/assaultcube_launcher).
