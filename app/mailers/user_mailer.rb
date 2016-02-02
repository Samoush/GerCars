class UserMailer < ApplicationMailer
  default from: "application.gercars@gmail.com" 

  def backup_succeeded
    attachments["data_backup.yml"] = File.read("#{Rails.root}/db/data.yml")
    mail(to: "samer1991@gmx.de", subject: "Das Backup wurde erfolgreich am #{Time.now.strftime("%d.%m.%Y")} erstellt")
  end 
end
