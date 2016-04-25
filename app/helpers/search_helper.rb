module SearchHelper

  def search_term?
    params[:search] != ""
  end

  def no_results?
    @results == []
  end
  
end
