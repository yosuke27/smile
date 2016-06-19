module ApplicationHelper
    def full_title(page_title = '')
        if page_title.empty?
            Constants::APP_NAME
        else
            "#{page_title} | #{Constants::APP_NAME}"
        end
    end
    
    def now
        Time.zone.now
    end
end
