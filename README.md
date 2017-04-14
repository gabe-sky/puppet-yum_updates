# yum_updates

This module implements a single structured fact that reports on whether a system has outstanding yum updates, and the number of updates that are outstanding.

*available:* returns a boolean reflecting whether there are updates outstanding.

*count:* returns an integer reflecting how many updates are outstanding.  If none are outstanding, it returns zero.
