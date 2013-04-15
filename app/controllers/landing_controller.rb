# encoding: UTF-8
class LandingController < ApplicationController
before_filter :initialize_mixpanel

   def initialize_mixpanel
      mix_panel_token = "cc36473896d6b730554c7156916e9d01"
      if Rails.env.production?
        mix_panel_token = "cc36473896d6b730554c7156916e9d01"
      elsif Rails.env.development?
        mix_panel_token = "3ce18c02e5494c43492445d3fee79af0"
      end
      @mixpanel ||= Mixpanel::Tracker.new(mix_panel_token, {:async => true})
   end

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
    if !session[:already_visitor]
      @mixpanel.track("Visited main page").delay
      session[:already_visitor] = true
    end
  end  

  def subscribe
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
    @mixpanel.track("Started filling form", {:email => @lead.email}).delay
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
       @mixpanel.track("Left e-mail for news", {:email => @lead.email, :android => @lead.android, :web_version => @lead.web_version, :windows_phone => @lead.windows_phone}).delay

       redirect_to({:controller => 'landing', :action => 'completed', :id => @lead.id})
     else
        flash[:notice] = "Произошла ошибка. Извините за неудобства"
        render('subscribe ')
     end
    end
  end
  
end
