class Authengine::UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'  
    @url         = "http://#{SITE_URL}/authengine/activate/#{user.activation_code}"  
    mail( :to => @recipients,
          :subject => @subject,
          :date => @sent_on,
          :from => @from
        )
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @url  = "http://#{SITE_URL}/authengine/login"
  end

  def forgot_password(user)
    setup_email(user)
    @subject    += 'You have requested to change your password'
    @url  = "http://#{SITE_URL}/authengine/reset_password/#{user.password_reset_code}"
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Your password has been reset.'
  end

  def message_to_admin(subject,body)
    @admin = User.find_by_login('admin')
    @recipients  = @admin.email
    @from        = @admin.email
    @subject     = "Mustard Seed Database - "
    @sent_on     = Time.now
    @subject    += subject
    @body  = body
  end

protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "Mustard Seed Database Administrator<#{ADMIN_EMAIL}>"
    @subject     = "Mustard Seed Database - "
    @sent_on     = Time.now
    @user        = user
  end
end
