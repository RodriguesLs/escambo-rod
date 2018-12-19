class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  
  def index
    @admins = Admin.all
  end
  
  
  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.create(params_admin)
    if @admin.save
        redirect_to backoffice_admins_path, notice: "Admin (#{@admin.email}) save successful"
    else
       render :new
     end
  end
  
  def update
    
    pass = params[:admin][:password]
    pass_conf = params[:admin][:password_confirmation] 
    
    if pass.blank? && pass_conf.blank?
      
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end
    
    
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path, notice: "Admin (#{@admin.email}) update successful"
    else
      render :edit
    end
  end
  
  def edit
  end
  
  def destroy
    
    admin_email = @admin.email
    
    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "Admin (#{admin_email}) destroyed successful"
    else
      render :index
    end

  end
  
  private
    def set_admin
      @admin = Admin.find(params[:id])
    end
  
    def params_admin
      params.require(:admin).permit(:email, :password, :password_confirmation)
    end
end
