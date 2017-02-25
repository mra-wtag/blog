module ApplicationHelper
  def markdown(text)
    @options ||= {
        autolink: true,
        space_after_headers: true,
        fenced_code_blocks: true,
        disable_indented_code_blocks: true,
        underline: true,
        highlight: true,
        footnotes: true,
        quote: true,
        tables: true,
        superscript: true,
        link_attributes: {rel: 'nofollow', target: "_blank"}
    }
    render_options = {
      hard_wrap: true,
      prettify: true,
    }
    render_html = Redcarpet::Render::HTML.new(render_options = {})
    @markdown ||= Redcarpet::Markdown.new(render_html, @options)
    @markdown.render(text).html_safe
  end
end
