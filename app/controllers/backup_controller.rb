
class BackupController < ApplicationController

  def do_backup
    %x[rake db:data:dump] #Rake::Task['db:data:dump'].invoke 
    UserMailer.backup_succeeded.deliver_now
    render 'order_cars/index'
  end 
end  