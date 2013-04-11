class Lead < ActiveRecord::Base
  attr_accessible :country, :email, :android, :windows_phone, :web_version
  validates_uniqueness_of :email

  after_create :send_notification

  def send_notification
  	#email = self.email

  	count_leads = Lead.all.count
    count_web_version = Lead.where(:web_version => true).count
    count_android = Lead.where(:android => true).count
    count_windows_phone = Lead.where(:windows_phone => true).count

  	MegaTron.delay.email_submit_notification(self)
  	MegaTron.delay.notify_team_new_lead(self,count_leads,count_web_version,count_android,count_windows_phone)
  end

end
