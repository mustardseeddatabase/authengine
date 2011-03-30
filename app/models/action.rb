class Action < ActiveRecord::Base
  belongs_to :controller
  
  has_many :action_roles, :dependent=>:delete_all
  has_many :roles, :through => :action_roles 
  
  # useractions are created in order to log actions performed by users, for recording in the log files
  has_many :useractions
  has_many :users, :through=>:useractions
  
  delegate :controller_name, :to=>:controller
  
  def <=>(other)
      sort_field <=> other.sort_field
  end
  
  def sort_field
    controller_name + action_name
  end
  
  def self.list
    all_actions = Hash.new
    all(:include=>:controller).each{|a| 
      all_actions[a.controller_name] ||= Hash.new 
      all_actions[a.controller_name][a.action_name] = a.id
      }
    all_actions  
  end
  
  def self.update_table_for(cont,action_names)
    remove_deleted_actions(cont, action_names)
    add_new_actions(cont, action_names)
  end

private
  # passed-in a controller object and a list of action name strings parsed from the xx_controller.rb file
  def self.remove_deleted_actions(cont, action_list)
    puts "remove deleted, action_list is #{action_list.inspect}"
    # first see what actions are in the table but not in the action_list pulled from the passe-in controller file
    controller_actions = cont.actions.map(&:action_name)
    puts "controller_actions: #{controller_actions.inspect}"
    actions_to_delete = controller_actions.delete_if{|a_name| action_list.include?(a_name)}
    # and delete them from the table
    puts "deleting actions #{actions_to_delete.inspect}"
    actions_to_delete.map! { |ad| find_by_controller_id_and_action_name(cont.id,ad).id }
    puts "action ids to be deleted #{actions_to_delete.inspect}"
    destroy(actions_to_delete)
  end
  
  def self.add_new_actions(cont, action_list)
    puts "add new, action_list is #{action_list.inspect}"
    # then see what actions are in the action list pulled from the controllers, but not in the table
    actions = cont.actions.map(&:action_name)
    puts "actions: #{actions.inspect}"
    action_list.delete_if{ |al| actions.include?(al) }    
    # and add them to the table
    puts "adding actions #{action_list.inspect}"
    action_list.each { |a| Action.create(:controller_id=>cont.id,:action_name=>a) } unless action_list.empty?
  end
  
end
