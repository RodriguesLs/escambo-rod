class Site::HomeController < SiteController
  def index
    @categories = Category.order(:description)
    @ads = Ad.descending_order().page(params[:page]).per(6)
    if Rails.env.production?
      @carousel = Ad.limit(3).order("RAND()")
    else
      @carousel = Ad.limit(3).order("RANDOM()")
    end
  end
end
