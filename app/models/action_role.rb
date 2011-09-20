class ActionRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :action

  # this is the key database lookup for checking permissions
  def self.exists_for(controller, action, user)
    joins([:action => :controller,:role =>{:user_roles => :user}]).
      where("actions.action_name" => action,
            "controllers.controller_name" => controller,
            "users.lastName" => user.lastName).
      exists?
  end

  def self.assign_developer_access
    developer_id = Role.developer.id
    Action.all.each do |a| 
      find_or_create_by_action_id_and_role_id(a.id, developer_id)
    end
  end
end
