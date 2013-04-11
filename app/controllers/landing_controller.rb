# encoding: UTF-8
class LandingController < ApplicationController

layout "landylayout"
  def index
  end

  def policy

  end

  def terms

  end

  def candy
  	render :layout => 'candylayout'
  end

  def landy
  	render :layout => 'landylayout'
    # Keen.publish("sign_ups", { :username => "lloyd", :referred_by => "harry" })
  end  

  def subscribe
    render :layout => 'landylayout'
    @lead = Lead.new
    @lead.android = false
    @lead.web_version = false
    @lead.windows_phone = false

    if params[:platform] == "web"
      @lead.web_version = true
    elsif params[:platform] == "android"
      @lead.android = true
    elsif params[:platform] == "windows_phone"
      @lead.windows_phone = true
    end
    #@mixpanel.track("Started filling form", {:email => @lead.email})
  end

   def download
    render :layout => 'landylayout'
   end
   
   def save_email
    @lead = Lead.new(params[:lead])
    if !Lead.find_by_email(@lead.email).blank?
      session[:error_message] = "E-mail #{@lead.email} уже зарегистрирован у нас"
      render('subscribe')
    elsif (@lead.web_version == false) && (@lead.android == false) && (@lead.windows_phone == false)
      session[:error_message] = "Вы вообще ничего не указали. Укажите платформу, которой вам не хватает"
      render('subscribe')
    elsif @lead.email.blank?
      session[:error_message] = "Укажите адрес e-mail"
      render('subscribe')
    else
     if @lead.save
       flash[:notice] = "Спасибо за указанные данные! Они помогут нам в разработке!"
       # Mixpanel track events
       #@mixpanel.track("Left e-mail for news", {:email => @lead.email}).delay

       redirect_to({:controller => 'landing', :action => 'completed', :id => @lead.id})
     else
        flash[:notice] = "Произошла ошибка. Извините за неудобства"
        render('subscribe ')
     end
    end
   end
  
end
