class ActionRole <ActiveRecord::Base
  belongs_to :role
  belongs_to :action
  
  def self.assign_developer_access
    developer_id = Role.developer.id
    Action.all.each do |a| 
      find_or_create_by_action_id_and_role_id(a.id, developer_id)
    end
  end
end
