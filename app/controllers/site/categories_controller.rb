class Site::CategoriesController < SiteController
  def show
    @categories = Category.order(:description)
    @ads = Ad.where(category_id: params[:id])
  end
end
