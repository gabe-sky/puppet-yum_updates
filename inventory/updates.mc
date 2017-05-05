# This is an MCollective inventory script.  It takes the results of an `mco
# inventory` command, parsing the facts discovered, and reporting on all hosts
# one per line.  It reports the hostname, OS, and how many yum updates are
# available.
#
# The output of this script is in a human-readable format.
#
# This script needs to be readable by the 'peadmin' user.  You may, for this
# reason, want to copy it to the peadmin user's home, /var/lib/peadmin and
# change its ownership to the peadmin user.
#
# To collect inventory of your Linux systems, invoke the command:
#
# sudo -u peadmin -i mco inventory -F osfamily=RedHat --script updates.mc

inventory do

  # The output format, similar to printf
  format "%s:\t%s\t%s\tUpdates available: %s"

  # Which facts go in the %s elements of the format
  fields { [ facts['hostname'],
             facts['os']['name'],
             facts['os']['release']['full'],
             # If the fact is defined, show the count, otherwise say 'unknown'
             if defined? facts['yum_updates']['count']
               facts['yum_updates']['count']
             else
               'unknown'
             end
           ]
  }

end
