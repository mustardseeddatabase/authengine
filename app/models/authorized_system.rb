module AuthorizedSystem
  def load_actions_list
    #@all_actions = Action.list
    #so we can determine the action id of any action from @all_actions[controller][action]
    #action_id is the id of the current page
    #@action_id = @all_actions[request.parameters["controller"]][request.parameters["action"]] unless @all_actions.empty? || @all_actions[request.parameters["controller"]].nil?
  end

  def load_permitted_actions
    #the list of action id's permitted for the roles of teh currently logged-in user
    #todo for some reason, this isn't being called when user tries to login, is redirected to the login page, and then is directed back to the desired page
    #@permitted_actions = Array.new
    #if logged_in?
      #user_role_ids = @current_user.roles.map(&:id)
      #@permitted_actions = ActionRole.find_all_by_role_id(user_role_ids).map(&:action_id)
    #end
  end

  def action_permitted?(controller, action, user)
    ActionRole.exists_for(controller, action, user)
  end

  def permitted?(controller, action, user)
    action_permitted?(controller, action, user) && logged_in?
  end

  # for each and every action, we check the configured permission
  # for the role(s) assigned to the logged-in user
  # The controller and action can be passed as parameters, to check whether or not to display a link/button
  # or else the current request controller/action are used to check whether or not to display a page
  def check_permissions(controller = request.parameters["controller"], action = request.parameters["action"])
    permission = false
    if !logged_in?
      logger.info "access denied: not logged in"
      access_denied
      return permission
    else

      #if @action_id.nil?
      #logger.info "in 'check permissions' redirecting: action not found, requesting #{controller}##{action}"
      #if request.xhr?
      #render :text=>"<div style='color:red'>Access permissions have not been configured for this information. Sorry.</div><div>Controller:#{controller}, Action:#{action}</div", :status=>404
      #else
      #flash.now[:error]= "Access permission has not been configured for the page you requested. Sorry.<br/>(controller: #{controller}, action: #{action})"
      #if request.env["HTTP_REFERER"].nil? then redirect_to home_path else redirect_to :back end
      #end
      #return permission
      #end

      permitted = permitted?(controller, action, current_user)
      #if @permitted_actions.include?(@action_id) then permission = true end
      if permitted then permission = true end
      if !permission
        logger.info "permission denied, #{controller}, #{action}"
        permission_denied
      end
    end
    permission
  end

end
