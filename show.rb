def search_event(events)
    print "write the id of the event you want to see: "
    id = gets.chomp.to_i
    event = events.find { |event| event[:id] == id }
  
    if event.nil?
      puts "there isn't any event with that ID "
    else
      start_time = DateTime.parse(event[:start_date]).strftime("%H:%M")
      if event.has_key?(:start_end)
        end_time = DateTime.parse(event[:end_date]).strftime("%H:%M") unless event[:end_date].empty?
        start_end = "#{start_time} #{end_time}"
      else
        start_end = "this event lasts all day"
      end
  
      
      if event[:notes].empty?
        notes = "There isn't any note here "
      else
        notes = event[:notes]
      end
  
      if event[:guests].empty?
        guests = "No guest in this event"
      else
        guests = event[:guests].join(", ")
      end
  
      puts "Event ID: #{event[:id]}"
      puts "date: #{event[:start_date].split("T")[0]}"
      puts "title: #{event[:title]}"
      puts "calendar: #{event[:calendar]}"
      puts "start_end: #{start_end}"
      puts "notes: #{notes}"
      puts "guests: #{guests}"
    end
  end