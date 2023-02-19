require_relative "create_event"

def update(events, id)
  event_index = events.index { |event| event[:id] == id }
  while event_index.nil?
    puts "ID not found"
    print "Event ID: "
    id = gets.chomp.to_i
    event_index = events.index { |event| event[:id] == id }
  end

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

  events[event_index][:start_date] = start_date_format
  events[event_index][:title] = title
  events[event_index][:end_date] = end_date_format
  events[event_index][:notes] = notes
  events[event_index][:guests] = guests
  events[event_index][:calendar] = calendar
end
