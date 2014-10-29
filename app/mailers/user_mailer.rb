class UserMailer < ActionMailer::Base
  default from: "noreply@koodohub.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.activate_account.subject
  #
  def activate_account(user)
    @user = user

    mail to: @user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password.subject
  #
  def reset_password(user)
    @user = user

    mail to: @user.email, subject: "Password reset"
  end
end
