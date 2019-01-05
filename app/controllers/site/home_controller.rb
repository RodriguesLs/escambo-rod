class Site::HomeController < SiteController
  
  def index
    @categories = Category.order(:description)
    @ads = Ad.descending_order().page(params[:page]).per(6)
  end
end
