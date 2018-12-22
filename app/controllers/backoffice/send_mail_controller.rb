class Backoffice::SendMailController < ApplicationController
    def edit
       @admin = Admin.find(params[:id]) 
    end
    
    def create
    end

end
