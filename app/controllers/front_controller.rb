class FrontController < ApplicationController
  def index
    
    @technologies = Technology.all(:order => "rand()" )
    @works = Work.all
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

  end

  def portfolio

    if params[:id]
      @work = Work.find params[:id]
      render :action => 'work' , :layout => false
    else
      @works = Work.all
      render :layout => false
    end
  end

end
