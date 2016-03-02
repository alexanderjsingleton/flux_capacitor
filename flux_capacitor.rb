# FIRST ATTEMPT

# require 'time'

# def flux_capacitor(time,mins)
#   the_time = Time.parse(time.to_s)
#   mins = the_time + 10*60
# end

# MVP

# def flux_capacitor(time,mins)
#   the_time = time.scan(/\d/).join('').to_i
#   meridian = time.scan(/(A|M|P)/).join('')
#   new_time = the_time + mins 
#   back_in_time = new_time.to_s.insert(-3,':') + " #{meridian}"
# end 

# FINAL REFACTOR

def flux_capacitor(time,mins)
  time_match = time.match(/^(\d?\d):(\d\d)/)
  meridian = time.scan(/(AM|PM)/).join('')
  if time_match
    strhours, strminutes, meridian = time_match.captures
    military_clock = (strhours.to_i * 60 + strminutes.to_i) + mins
    adjusted_military_clock_hours = military_clock / 60
    adjusted_military_clock_minutes = military_clock - (60 * adjusted_military_clock_hours)
    if adjusted_military_clock_hours > 12
      meridian = "PM"
      adjusted_military_clock_hours -= 12
      else false
    end
    return "%d:%02d %s" % [adjusted_military_clock_hours, adjusted_military_clock_minutes, meridian]
  else
    raise(ArgumentError, "Invalid format, expected [H]H:MM {AM|PM}, got #{time}")
  end
end 

# [CODE REVIEW](http://codereview.stackexchange.com/questions/121469/adding-minutes-to-a-time-value-in-ruby/121589#121589)

# The edge cases (carry values of hours/meridian) is the core of this algorithm, IMO.

# time.scan(/\d/): That's too general, better use a regexp that mimics exactly the input you should have.

# Why /(A|M|P)/ instead of (AM|PM)?

# new_time.to_s.insert(-3,':'). Algorithms are cleaner with no in-place updates, create new variables.

# It's not stated what you should do for invalid inputs, but a "production-quality" code should consider it somehow. Two options: return nil or raise an exception.

# def flux_capacitor(strtime, minutes_diff)
#   time_match = strtime.match(/^(\d?\d):(\d\d) (AM|PM)$/)
#   if time_match
#     strhour, strminute, meridian = time_match.captures
#     hours_carry, new_minute = (strminute.to_i  + minutes_diff).divmod(60)
#     new_hour = (strhour.to_i - 1 + hours_carry) % 12 + 1
#     meridian_crosses = ((strhour.to_i % 12) + hours_carry) / 12
#     new_meridian = (meridian.eql?("AM") == meridian_crosses.even?) ? "AM" : "PM"
#     "%d:%02d %s" % [new_hour, new_minute, new_meridian]
#   else
#     raise(ArgumentError, "Invalid format, expected [H]H:MM {AM|PM}, got #{strtime}")
#   end
# end

puts flux_capacitor("9:13 AM",10)
puts flux_capacitor("9:13 PM",10)
p flux_capacitor("10:13 PM",10).class

# # Edge-case
puts flux_capacitor("11:59 AM", 62)
# flux_capacitor("9:xy AM",10) 

# DOX

# http://ruby-doc.org/core-2.2.3/Time.html
# https://www.ruby-forum.com/topic/125709
# https://www.ruby-forum.com/topic/104359
# http://apidock.com/ruby/String/insert
# http://rubular.com/