module ApplicationHelper

  def markdown(text)
    render_options = {
        filter_html: true,
        hard_wrap: true,
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true, highlight: true, superscript: true, underline: true, quote: true)
    markdown.render(text).html_safe
  end

end
