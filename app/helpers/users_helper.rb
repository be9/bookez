module UsersHelper
  def users_page_title(user)
    self_page = " (this is you)" if user == current_user
    "#{h(user.login)}'s page#{self_page}"
  end

  def link_to_current_user(options)
    link_to current_user.login, current_user, options if current_user
  end

  def link_to_user(user, params={})
    raise "Invalid user" unless user
    u = User.find user[:id]
    content = params[:content] || u.login
    link_to h( content ), user_path(u), params
  end
end
