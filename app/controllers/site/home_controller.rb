class Site::HomeController < SiteController
  
  def index
    @categories = Category.order(:description)
    @ads = Ad.limit(6).order(created_at: :desc)
  end
end
