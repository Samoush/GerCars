
class BackupController < ApplicationController

  def do_backup
    %x[rake db:data:dump] 
    UserMailer.backup_succeeded.deliver_now
    render 'user_mailer/backup_page_response'
  end 
end  