class Site::CategoriesController < SiteController
  def show
    @categories = Category.order(:description)
    @category = Category.friendly.find(params[:id])
    @ads = Ad.where(category_id: @category)
  end
end
