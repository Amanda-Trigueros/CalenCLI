require "colorize"

BLANK_SPACE_FOR_ALL_DAY_EVENTS = 13
BLANK_SPACE_BELOW_DATE_COLUMN = 10

def group_events_by_date(events)
  events.group_by { |event| DateTime.parse(event[:start_date]).strftime("%a %b %e") }
end

def get_hours_formatted(datetime)
  DateTime.parse(datetime).strftime("%H:%M")
end

def complete_empty_days
  # code here
end

def color_calendar(message, calendar_type)
  case calendar_type
  when "web-dev"
    message.colorize(:light_red)
  when "english"
    message.colorize(:light_magenta)
  when "soft-skills"
    message.colorize(:light_green)
  else
    message.colorize(:cyan)
  end
end

def ask_for_action_prompt
  puts "-" * 60
  puts "list | create | show | update | delete | next | prev | #{'exit'.colorize(:green)}"
  puts ""
  print "action: "
  gets.chomp.strip
end

def order_events(events)
  all_day_events, events_with_timerange = events.partition { |event| event[:end_date] == "" }
  ordered_events_with_time_range = events_with_timerange.sort_by { |event| DateTime.parse(event[:start_date]) }
  all_day_events + ordered_events_with_time_range
end

def list_events(events_list)
  puts "#{'-' * 30}Welcome to CalenCli#{'-' * 30}\n\n"
  hashed_events = group_events_by_date(events_list)  # {"12-02-2023" => [{e1},{e2}], "13-02-2023" => [{e1}]}
  hashed_events.each do |day, events|
    ordered_events = order_events(events)
    ordered_events.each_with_index do |event, index|
      is_all_day_event = event[:end_date].empty?
      if is_all_day_event
        blanks = " " * BLANK_SPACE_FOR_ALL_DAY_EVENTS
      else
        start_hour = get_hours_formatted(event[:start_date])
        end_hour = get_hours_formatted(event[:end_date])
        hours = "#{start_hour} - #{end_hour}"
      end

      date = if index.zero?
               day
             else
               " " * BLANK_SPACE_BELOW_DATE_COLUMN
             end
      event_formatted = "#{blanks} #{hours} #{event[:title]} (#{event[:id]})"
      puts "#{date} " + color_calendar(event_formatted, event[:calendar])
    end
    puts ""
  end
end
