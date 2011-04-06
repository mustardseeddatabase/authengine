module ApplicationHelper
  def admin_logout
    content_tag(:div, :id => :admin_logout) do
      if logged_in? && current_user.roles.map(&:name).any?{|r| r=~/admin|developer/i } 
        concat content_tag(:a, "Administration", :href => authengine_admin_path, :style => 'padding-right:30px')
      end

      if logged_in?
        concat content_tag(:a, "Logout", :href => logout_path)
      end
    end
  end

  def submit_or_return_to(return_path)
    render :partial=>'authengine/shared/submit_or_return_to', :locals=>{:return_path=>return_path}
  end

private
  def admin_link
    if logged_in? && current_user.roles.map(&:name).any?{|r| r=~/admin|developer/i }
      content_tag(:a, "Administration", :href => authengine_admin_path, :style => 'padding-right:20px')
    else
      ""
    end
  end

  def logout_link
    if logged_in?
      content_tag(:a, "Logout", :href => logout_path)
    else
      ""
    end
  end

end
