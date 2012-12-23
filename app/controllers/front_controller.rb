class FrontController < ApplicationController
  def index

    @technologies = Technology.all(:order => "rand()" )
    @works = ordered_works
    @contact = Contact.new

    if params[:layout] == 'false'
      render :layout => false
    end

  end

  def curriculum

    require 'net/http'
    require 'uri'

    parsed_url = URI.parse('https://docs.google.com/document/pub?id=1b67GGHMnwoEVXUJ2d0E8ETrz-n9PVy9zCdTcnWZdJ2Y')
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(parsed_url.request_uri)
    response = http.request(request)

    @curriculum = response.body
    @curriculum = @curriculum.gsub(/<style.*?>[\s\S]*<\/style>/i, "")
    
    render :layout => 'clean'

  end

  def portfolio

    if params[:id]
      @work = Work.find params[:id]
      render :action => 'work' , :layout => false
    else
      @works = ordered_works
      render :layout => false
    end
  end

  def ordered_works
    Work.all(:order => 'date DESC')
  end

  def send_mail
    
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    message = params[:message]
    
    render :inline =>
      "Mail sended with success!"

    
  end 
  

end
