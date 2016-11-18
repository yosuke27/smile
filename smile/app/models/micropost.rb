class Micropost < ActiveRecord::Base

    validates :content, presence: true, length: { maximum: 140 }

    scope :datecode_between, -> from, to {
        if from.present? && to.present?
            where(datecode: from..to)
        elsif from.present?
            where('datecode >= ?', from)
        elsif to.present?
            where('datecode <= ?', to)
        end
    }
end
