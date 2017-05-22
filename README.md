# yum_updates


## Class

This module implements a single, very simple class, yum_upates, which you can use to periodically run `yum -y update` on some machines.  This class defaults to not actually doing anything; you will need to set its "autoupdate" parameter to true, if you actually want it to run the yum command.

For instance, declare it like this, to have it run updates once per weekday.

```
class { 'yum_updates':
  autoupdate => true,
}
```

Alternately, you might use Hiera to decide what nodes apply updates and which ones don't.  Since the class defaults to doing, nothing, you simply need to add a single key to machines that *do* need to apply updates.  For instance, with the following yaml:

```
---
yum_updates::autoupdate: true
```

There's a class parameter if you want to tack anything on to the end of the yum command.  The string is just tacked on, verbatim, to the command.  For instance, to leave out a repo from the update run:

```
class { 'yum_updates':
  autoupdate => true,
  append_to_command => '--disablerepo=epel',
}
```


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
