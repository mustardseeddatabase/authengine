class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.signup_notification(user).deliver
  end
  
  def after_save(user)
    UserMailer.activation(user).deliver if user.pending? # pending? true if user is activated
    UserMailer.forgot_password(user).deliver if user.recently_forgot_password?
    UserMailer.reset_password(user).deliver if user.recently_reset_password?
  end
end
