class UserMailer < ApplicationMailer
  def sample_email(user)
    @user = user
    @url  = 'http://www.yourarticles.com'
    mail(to: @user.email, subject: 'Welcome Email')
  end
end
