class Attendance < ApplicationRecord
  after_create :new_guest_send

  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true

  def new_guest_send
    AttendanceMailer.new_guest_email(self).deliver_now
  end
end
