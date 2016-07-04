module MicropostsHelper
    include ApplicationHelper

    # 引数を元に現在時刻か指定日を取得します。
    def to_date_or_now(string)
        if string.nil? || string.empty?
            return now
        end
        return string.to_time
    end

    # Dateを日付コードに変換します。
    def to_datecode(date)
        date.strftime('%Y%m%d')
    end
    
    # 前回の日曜日の日付コードを取得します。
    def last_sunday_datecode(date)
        to_datecode date.beginning_of_week(:sunday)
    end
    
    # 次回の土曜日の日付コードを取得します。
    def next_saturday_datecode(date)
        to_datecode date.beginning_of_week(:saturday).since(1.week)
    end
    
    def weeks
        ["日", "月", "火", "水", "木", "金", "土"]
    end
end
