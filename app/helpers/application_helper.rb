module ApplicationHelper
  def full_title(page_title)
    if page_title.empty?
      "What page ra ithi????"
    elsif page_title.downcase.include? "signup"
      link_to "Login", login_path, class:"navbar-item"
    elsif page_title.downcase.include? "login"
      link_to "Signup", new_user_path, class:"navbar-item"
    elsif page_title.downcase.include? "question"
      link_to "Create New Questions", new_question_path, class:"navbar-item"
    end
  end
end
