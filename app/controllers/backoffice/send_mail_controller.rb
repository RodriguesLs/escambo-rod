class Backoffice::SendMailController < ApplicationController
   
    def edit
       @admin = Admin.find(params[:id]) 
    end
    
    def create
    
    begin
    
    AdminMailer.send_email(current_admin, params[:'recipient-text'], params[:'subject-text'], params[:'message-text']).deliver_now
    
    @notify_message = "Email enviado com sucesso"
    @notify_flag = "success"
    rescue
    @notify_message = "Erro ao enviar email, tente novamente."
    @notify_flag = "error"
    end
    # Método padrão de recebimento, mas é bom constar.
    respond_to do |format|
        format.js
    end
    
    end
end