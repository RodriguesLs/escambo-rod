class Site::HomeController < SiteController
  
  def index
    @categories = Category.order(:description)
    @ads = Ad.descending_order()
  end
end
