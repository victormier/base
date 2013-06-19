module ApplicationHelper
  def view_id
    "#{controller.controller_name} #{controller.action_name.downcase}"
  end
end
