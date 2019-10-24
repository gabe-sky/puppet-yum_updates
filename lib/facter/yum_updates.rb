# This simple custom fact uses the output of a `yum check-update` command to
# determine how many updates are available for a system.
#
# It returns two values, as a structured fact.
#
#   yum_updates['available']: a boolean reflecting if updates are available
#   yum_updates['count']: an integer with the count of outstanding updates

Facter.add(:yum_updates) do
  confine :osfamily => 'RedHat'

  setcode do

    # Create a hash and put in some default values.
    results = Hash.new
    results['count'] = 0
    results['available'] = false

    # Invoke check-update to list available updates.  Turn the raw output into
    # an array of lines.  Then inspect each line.  Wait only thirty seconds.
    lines = Facter::Core::Execution.execute('yum check-update --quiet', :timeout => 30)
      .split("\n")
      .each do |line|

      # If it looks like the line is a package name, version, and source, add
      # one to the count, and (re)set available to true.
      if line.match?(/^\S+\s+\d\S+\s+\S+\s*$/)
        results['count'] += 1
        results['available'] = true
      end

    end

    # Return the hash of count and available as the fact's value.
    results

  end
end
