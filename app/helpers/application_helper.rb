module ApplicationHelper
  def render_with_locals(template, locals={})
    args = { partial: template, locals: locals }
    render(args)
  end
end
