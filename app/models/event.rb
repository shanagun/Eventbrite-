class Event < ApplicationRecord
  belongs_to :admin, class_name: "User"
  has_many :attendances
  has_many :users, through: :attendances

  # validation des attributs
  validates :start_date, presence: true
  validate :start
  validates :duration, presence: true
  validate :duration
  validates :title, presence: true, length: {in: 5..140}
  validates :description, presence: true, length: {in: 20..1000}
  validates :price, presence: true, numericality: {greater_than: 1, less_than: 1000}
  validates :location, presence: true

  def start
    unless start_date > Time.zone.today
      start_date.errors[:time] << 'event cannot be in the past'
    end
  end

  def multiple
    if (self.duration % 5) != 0
      self.errors[:base] << 'duration must be a multiple of 5'
    end
  end

end