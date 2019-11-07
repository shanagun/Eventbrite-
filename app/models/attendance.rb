class Attendance < ApplicationRecord
  after_create :new_guest_send

  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true

  def self.users(event)
    @attendees = Array.new
    @users = Attendance.where(event_id: event.id)
    @users.each do |user|
        @attendees << user.user
    end
    return @attendees
  end


  def new_guest_send
    AttendanceMailer.new_guest_email(self).deliver_now
  end
end
