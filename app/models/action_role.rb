class ActionRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :action

  # this is the key database lookup for checking permissions
  # returns true if there is a user_role
  # which explicitly permits (i.e. the role has action_role associations)
  # the specified controller and action for the specified user
  def self.permits_access_for(controller, action, role_ids)
    joins([:role, :action => :controller ]).
      where("roles.id" => role_ids).
            where("actions.action_name" => action).
            where("controllers.controller_name" => controller).
            exists?
  end

  def self.assign_developer_access
    developer_id = Role.developer.id
    Action.all.each do |a| 
      find_or_create_by_action_id_and_role_id(a.id, developer_id)
    end
  end
end
