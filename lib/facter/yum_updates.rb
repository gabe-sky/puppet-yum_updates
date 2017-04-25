# This simple custom fact uses the output of a `yum check-update` command to
# determine whether updates are available for a system, and how many.
#
# It returns two entries, as a structured fact.
#
#   yum_updates.count:  gives the count of outstanding updates as an integer
#   yum_updates.available:  gives a boolean reflecting if updates are available

Facter.add(:yum_updates) do
  confine :osfamily => 'RedHat'

  results = Hash.new

  # Invoke check-update to list available updates, use grep to exclude blank
  # lines, and then count the number of remaining lines.
  # Convert this from a string to an integer and assign it to 'count'.
  results['count'] = Facter::Core::Execution.exec('yum check-update --quiet | grep -v "^$" | wc -l').to_i

  # If the result was greater than zero, set 'avaialble' to true, to indicate
  # that there are outstanding updates.  Otherwise set it to false.
  if results['count'] > 0
    results['available'] = true
  else
    results['available'] = false
  end

  setcode do
    results
  end

end
