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
    haml_tag :table, {:style => 'padding-top:30px'} do
      haml_tag :tr do
        haml_tag :td, {:width => '180px'} do
          haml_tag :input, {:type => 'submit', :value => 'Save'}
        end
        haml_tag :td do
          haml_tag :a, "Cancel", {:href => return_path}
        end
      end
    end
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
