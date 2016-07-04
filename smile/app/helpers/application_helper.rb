module ApplicationHelper
    
    # ページのタイトルを取得します。
    def full_title(page_title = '')
        if page_title.empty?
            Constants::APP_NAME
        else
            "#{page_title} | #{Constants::APP_NAME}"
        end
    end
    
    # 現在時刻を取得します。
    def now
        Time.zone.now
    end
end
