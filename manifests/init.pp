# This class, when applied to a system, does nothing.  *Unless* you set the
# "autoupdate" parameter to true.
#
# This means it's safe to include this class on a very wide swath of machines,
# and then just set "autoupdate" to true on some safe subset.  You might do
# this in Hiera, or by making a node group in the Enterprise Console.
#
# By default, the exec in this class will timeout after ten minutes.  If you
# have a ton of updates outstanding, you might hit this limit.  If you do,
# yum will likely have installed as many updates as it had time for, even if
# the exec timed out, so don't be surprised if the logs say the exec failed,
# but your count of outstanding updates has dropped anyway, in that rare case.
#
# If you like you can add flags and things to the command, by putting them in
# a single string, as $append_to_command.  They just get tacked on to the end
# of the command verbatim.


class yum_updates (
  $autoupdate         = false,
  $autoupdate_period  = 'daily',
  $autoupdate_range   = '10-16',
  $autoupdate_weekday = ['Mon','Tue','Wed','Thu','Fri'],
  $autoupdate_timeout = 600,
  $append_to_command  = '',
) {


  # Optionally run a yum update once per weekday (or whatever span is passed
  # in as the yum_updates::autoupdate_* parameters.).
  if $autoupdate {
    schedule { 'Yum updates allowed':
      period  => $autoupdate_period,
      range   => $autoupdate_range,
      weekday => $autoupdate_weekday,
    }
    exec { "yum -y update ${append_to_command}":
      path     => $::path,
      schedule => 'Yum updates allowed',
      timeout  => $autoupdate_timeout,
    }
  }

}
