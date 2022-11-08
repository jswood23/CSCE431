# October 16th, 2022 10:17pm
Time::DATE_FORMATS[:full_english] = lambda { |time| time.strftime("%A, %B #{time.day.ordinalize}, %Y %l:%M%P")}

# 10-16-2022
Time::DATE_FORMATS[:get_date] = lambda { |time| time.strftime("%m-%d-%Y")}

# 05:21 PM
Time::DATE_FORMATS[:get_time] = lambda { |time| time.strftime("%I:%M %p")}

# NOV
Time::DATE_FORMATS[:get_month] = lambda { |time| time.strftime("%b").upcase!}
# NOV
Time::DATE_FORMATS[:get_day] = lambda { |time| time.strftime("%d")}
# NOV
Time::DATE_FORMATS[:get_year] = lambda { |time| time.strftime("%Y")}