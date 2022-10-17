# October 16, 2022 10:17pm
Time::DATE_FORMATS[:full_english] = lambda { |time| time.strftime("%A, %B #{time.day.ordinalize}, %Y %l:%M%P")}