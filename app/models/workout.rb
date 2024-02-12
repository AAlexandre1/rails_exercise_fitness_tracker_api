class Workout < ApplicationRecord
    belongs_to :user

    validates :name, presence: true, length: { maximum: 50 }
    validates :date, presence: true
    validates :duration, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 240, only_integer: true }
    validate :unique_name_per_date

    def unique_name_per_date
        if user && user.workouts.where(name: name, date: date).exists?
            errors.add(:name, "This workout name was already added for this date.")
        end
    end
end
