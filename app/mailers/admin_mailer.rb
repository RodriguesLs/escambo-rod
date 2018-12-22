class AdminMailer < ApplicationMailer
    def update_email(current_admin, admin)
      @current_admin = current_admin
      @admin = admin
      mail(to: @admin.email, subject: "Your dates are changed")
    end
    
    def send_email(current_admin, recipient, subject, message)
      @current_admin = current_admin
      @recipient = recipient
      @subject = subject
      @message = message
      mail(to: @recipient, subject: @subject)
    end
end
