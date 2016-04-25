module ApplicationHelper

  def markdown(text)
    render_options = {
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow' }
    }
    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = {
      autolink:           true,
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  def new_subscriber
    Subscriber.new
  end

  def new_blogger
    Blogger.new
  end

  def on_blogger_page?
    @blogger ||= false
  end

  def blogger_page
    return params[:blogger_id] ? 
      (Blogger.find_by(slug: params[:blogger_id])).username : ""
  end
  
end
