# yum_updates

## Fact

This module implements a single structured fact that reports on whether a system has outstanding yum updates, and the number of updates that are outstanding.

For instance, a system with eighty-two outstanding updates will report the following:

    {
      count => 82,
      available => true
    }

#### `count`

Is an integer reflecting how many updates are outstanding.  If none are outstanding, it returns zero.

#### `available`

Is a boolean reflecting whether `count` indicates that more than one update is outstanding.

## Inventory Script

This module includes a sample MCollective inventory script, which can be used to list all running hosts, and their current count of yum updates outstanding.  Use the `mco inventory` command's `--script` argument, to use the script.  For instance on Puppet Enterprise, with the script in /tmp:

    sudo -u peadmin -i mco inventory -F osfamily=RedHat --script /tmp/updates.mc

The script will need to be readable by the user running MCollective.  For instance, if you are running Puppet Enterprise, the "peadmin" user will need to be able to read the script.
