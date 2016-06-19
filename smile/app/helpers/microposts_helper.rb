module MicropostsHelper
    include ApplicationHelper

    def to_date_or_now(string)
        date = string.to_time
        if date.nil? || date.empty?
            date = now
        end
        return date
    end

    def to_datecode(date)
        date.strftime('%Y%m%d')
    end
    
    def last_sunday_datecode(date)
        to_datecode date.beginning_of_week(:sunday)
    end
    
    def next_saturday_datecode(date)
        to_datecode date.beginning_of_week(:saturday).since(1.week)
    end
end
