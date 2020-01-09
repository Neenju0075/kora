module ApplicationHelper
  def full_title(page_title)
    if page_title.empty?
      "What page???? add title to the page!!"
    elsif page_title.downcase.include? "signup"
      link_to "Login", login_path, class:"button is-link is-light is-pulled-right"
    elsif page_title.downcase.include? "login"
      link_to "Signup", new_user_path, class:"button is-success is-light is-pulled-right"
    end
  end
end
