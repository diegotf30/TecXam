module ApplicationHelper

  def bold_if_current(current_path)
    return 'bold' if current_page?(current_path)
  end
end
