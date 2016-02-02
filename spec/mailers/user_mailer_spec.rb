require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  it 'sends an email' do
    expect { UserMailer.backup_succeeded.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
  
  describe 'backup_succeeded' do
    let(:mail) { UserMailer.backup_succeeded }

    it 'renders the subject' do
      expect(mail.subject).to eql("Das Backup wurde erfolgreich am #{Time.now.strftime("%d.%m.%Y")} erstellt")
    end  

    it 'renders the receiver mail' do
      expect(mail.to).to eql(["samer1991@gmx.de"])
    end  

    it 'renders the sender email' do
      expect(mail.from).to eql(["application.gercars@gmail.com"])
    end  

    it 'assigns whole body' do
      expect(mail.body.encoded).to match("Sie haben das Backup erfolgreich erstellt.")
      expect(mail.body.encoded).to match("Somit koennen ihre Daten im Falle eines Verlustes wiederhergestellt werden.")
      expect(mail.body.encoded).to match("Ihr Application-GermanCars Team")
    end  
  end  
end
