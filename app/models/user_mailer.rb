class UserMailer < ActionMailer::Base

  def forgot_password(user, key)
    @user, @key = user, key
    mail( :subject => "#{app_name} -- forgotten password",
          :to      => user.email_address,
          :from    => "no-reply@#{host}")
  end

end
