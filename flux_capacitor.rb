# http://ruby-doc.org/core-2.2.3/Time.html
# https://www.ruby-forum.com/topic/125709
# https://www.ruby-forum.com/topic/104359
# http://apidock.com/ruby/String/insert

# require 'time'

# def flux_capacitor(time,mins)
#   the_time = Time.parse(time.to_s)
#   mins = the_time + 10*60
# end

def flux_capacitor(time,mins)
  the_time = time.scan(/\d/).join('').to_i
  meridian = time.scan(/(A|M|P)/).join('')
  new_time = the_time + mins 
  back_in_time = new_time.to_s.insert(-3,':') + " #{meridian}"
end

puts flux_capacitor("9:13 AM",10)