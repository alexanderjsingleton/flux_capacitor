require 'time'

def flux_capacitor(time,mins)
  the_time = Time.parse(time.to_s)
  mins = the_time + 10*60
end

puts flux_capacitor("9:13 AM",10)