module AuthorizedSystem

  def action_permitted?(controller, action, user)
    ActionRole.permits_access_for(controller, action, user)
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
    elsif permitted?(controller, action, current_user)
      permission = true
    else
      logger.info "permission denied, #{controller}, #{action}"
      permission_denied
    end
    permission
  end

end
