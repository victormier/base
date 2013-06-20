# encoding: UTF-8

class Notifier < ActionMailer::Base
  default :from => "Base <victormier@gmail.com>", :charset => "utf-8"

  def reset_password_email(user)
    @user = user

    mail(to: user.email, subject: "Reset password instructions")
  end
end
