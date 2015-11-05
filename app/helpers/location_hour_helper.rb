# A helper file to parse the hours of a given location
module LocationHourHelper
  def format_hours(hours)
    if hours.keys.count == 1 && hours.keys[0].count == 7
      "Daily, #{format_time(hours.values[0][0])} – #{format_time(hours.values[0][1])}"
    elsif hours.keys.count == 1 && hours.keys[0] == [0, 6]
      "Weekends, #{format_time(hours.values[0][0])} – #{format_time(hours.values[0][1])}"
    elsif hours.keys.count == 1 && hours.keys[0].count == 1
      "#{Date::DAYNAMES[hours.keys[0][0]]} #{format_time(hours.values[0][0])} – #{format_time(hours.values[0][1])}"
    elsif hours.keys.count == 1 && consecutive_days?(hours.keys[0].sort)
      "#{Date::DAYNAMES[hours.keys[0].sort.first]} – #{Date::DAYNAMES[hours.keys[0].sort.last]}, #{format_time(hours.values[0][0])} – #{format_time(hours.values[0][1])}"
    elsif hours.keys.count == 2 && ((consecutive_days?(hours.keys[0].sort) && hours.keys[1] == [0, 6]) ||
      (consecutive_days?(hours.keys[1].sort) && hours.keys[0] == [0, 6]))
      "#{Date::DAYNAMES[hours.keys[0].sort.first]} – #{Date::DAYNAMES[hours.keys[0].sort.last]}, #{format_time(hours.values[0][0])} – #{format_time(hours.values[0][1])}<br />Weekends, #{format_time(hours.values[1][0])} – #{format_time(hours.values[1][1])}".html_safe
    end
  end

  def format_time(time)
    if time < 12
      hour = time.to_i
      hour = 12 if hour == 0
      minute = (time.frac * 60).to_i

      "#{hour}:#{format('%02d', minute)}am"
    else
      hour = time.to_i - 12
      hour = 12 if hour == 0
      minute = (time.frac * 60).to_i

      "#{hour}:#{format('%02d', minute)}pm"
    end
  end

  def consecutive_days?(days)
    (1..(days.length - 1)).each do |index|
      return false if days[index] - days[index - 1] != 1
    end

    true
  end
end
