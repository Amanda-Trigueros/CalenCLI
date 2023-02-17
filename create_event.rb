def valid_date?(date)
  valid_format = "%Y-%m-%d"
  !!(date.match(/\d{4}-\d{2}-\d{2}/) && DateTime.strptime(date, valid_format))
rescue ArgumentError
  false
end

def valid_calendar?(calendar)
  valid_calendars = ["", "web-dev", "english", "soft-skills"]
  valid_calendars.include?(calendar)
end

def valid_start_end?(start_end)
  return true if start_end == ""

  valid_range = true
  start_hour, end_hour = start_end.split
  start_hour = start_hour.split(":")
  end_hour = end_hour.split(":")
  if start_hour[0] == end_hour[0]
    valid_range = start_hour[1] < end_hour[1]
  elsif start_hour[0] > end_hour[0]
    valid_range = false
  else
    valid_range = true
  end
  !!(start_end.match(/\d{2}:\d{2} \d{2}:\d{2}/) && valid_range)
rescue ArgumentError
  false
end

def create_event(events, id)
  print "Date (YYYY-MM-DD): "
  date = gets.chomp
  until valid_date?(date)
    puts "Invalid Date"
    print "Date (YYYY-MM-DD): "
    date = gets.chomp
  end

  print "Title: "
  title = gets.chomp
  while title.empty?
    puts "Title shouldn't be empty"
    print "Title: "
    title = gets.chomp
  end

  print "Calendar: "
  calendar = gets.chomp.strip
  until valid_calendar?(calendar)
    puts "Valid calendars: web-dev, english, soft-skills or defeault"
    print "Calendar: "
    calendar = gets.chomp.strip
  end

  print "Start_End (HH:MM HH:MM): "
  start_end = gets.chomp
  until valid_start_end?(start_end)
    puts "Invalid format or invalid range, format should be HH:MM HH:MM"
    print "Start_End (HH:MM HH:MM): "
    start_end = gets.chomp
  end

  print "Notes: "
  notes = gets.chomp

  print "Guests: "
  guests = gets.chomp.split(", ")

  if start_end == ""
    start_date_format = "#{date}T00:00:00-05:00"
    end_date_format = ""
  else
    start_hour, end_our = start_end.split
    start_date_format = "#{date}T#{start_hour}:00-05:00"
    end_date_format = "#{date}T#{end_our}:00-05:00"
  end

  new_event = {
    id:,
    start_date: start_date_format,
    title:,
    end_date: end_date_format,
    notes:,
    guests:,
    calendar:
  }
  events.push(new_event)
end
