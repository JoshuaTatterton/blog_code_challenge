module SearchHelper

  def search_term?
    params[:search] != ""
  end

  def no_results?
    @results == []
  end

  def hide?
    @hide ||= false
  end

  def blogger_search?
    params[:blogger] != ""
  end

  def previous_search
    @search_term if @search_term
  end

  def blogger_search
    @blogger_search if @blogger_search
  end

  def blogger?
    Blogger.where("lower(username) = ?", params[:blogger].downcase).first
  end

end
