# encoding: UTF-8
class MegaTron < ActionMailer::Base
  default from: "almas@yumixo.com"
  
  def registration_confirmation(lead)
      @lead = lead      
      mail(:to => lead.email, :subject => "Привет от Yumixo!")
  end
  
  def email_submit_notification(lead)
      @lead = lead
      mail(:to => lead.email, :subject => "Hello from Yumixo!")
  end

  def notify_team_new_lead(lead,count,webs,androids,wps)
    @lead = lead

    @count_leads = count
    @count_web_version = webs
    @count_android = androids
    @count_windows_phone = wps
    mail(:to => "managers@yumixo.com", :subject => "+1 на Yumixo")
  end
  
end
