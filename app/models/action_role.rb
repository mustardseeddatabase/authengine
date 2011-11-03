class ActionRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :action

  # this is the key database lookup for checking permissions
  def self.permits_access_for(controller, action, user)
    p = exists_for('PersistentUserRole', controller, action, user)
    s = exists_for('SessionUserRole', controller, action, user)
    u = user_has_session_role?(user)
    # either it's permitted by both session and persistent user_roles
    # or the user doesn't have any session_user_roles and it's permitted
    # by the persistent_user_role
    (s || !u) && p
  end

  def self.user_has_session_role?(user)
    user.session_user_roles.any?
  end

  # returns true if there is a user_role of the specified type
  # which explicitly permits (i.e. the role has action_role associations)
  # the specified controller and action for the specified user
  def self.exists_for(user_role_type, controller, action, user)
    joins([:action => :controller,:role =>{:user_roles => :user}]).
      where("user_roles.type" => user_role_type).
            where("actions.action_name" => action).
            where("controllers.controller_name" => controller).
            where("users.login" => user.login).
            exists?
  end

  def self.assign_developer_access
    developer_id = Role.developer.id
    Action.all.each do |a| 
      find_or_create_by_action_id_and_role_id(a.id, developer_id)
    end
  end
end
