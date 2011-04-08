class UserObserver < ActiveRecord::Observer
  def after_create(user)
    Authengine::UserMailer.signup_notification(user).deliver
  end
  
  def after_save(user)
    Authengine::UserMailer.activation(user).deliver if user.pending? # pending? true if user is activated
    Authengine::UserMailer.forgot_password(user).deliver if user.recently_forgot_password?
    Authengine::UserMailer.reset_password(user).deliver if user.recently_reset_password?
  end
end
