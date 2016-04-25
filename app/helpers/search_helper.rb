module SearchHelper

  def search_term?
    params[:search] != ""
  end
  
end
