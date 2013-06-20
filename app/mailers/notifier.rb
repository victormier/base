# encoding: UTF-8

class Notifier < ActionMailer::Base
  default :from => "Base <victormier@gmail.com>", :charset => "utf-8"

  def reset_password_email(user)
    @user = user

    mail(to: user.email, subject: t('subject', :scope => 'notifier.reset_password_email'))
  end
end
