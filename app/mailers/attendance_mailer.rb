class AttendanceMailer < ApplicationMailer
  default from: 'no-reply@monsite.fr'

  def new_guest_email(attendance)
    @attendance = attendance
    @admin = User.find(@attendance.event.admin_id)
    @url = 'http://monsite.fr/'
    mail(to: @admin.email, subject: 'Vous avez un nouvel invité !')
  end

end
