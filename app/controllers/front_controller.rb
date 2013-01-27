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

    # require 'net/http'
    # require 'uri'
    #
    # parsed_url = URI.parse('https://docs.google.com/document/d/192WdGfZ8f-JYKjaITGNgTu_u0w-QvbW5MeESZArOFyw/pub')
    # http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    # http.use_ssl = true
    #
    # request = Net::HTTP::Get.new(parsed_url.request_uri)
    # response = http.request(request)
    #
    # @curriculum = response.body
    # @curriculum = @curriculum.gsub(/<style.*?>[\s\S]*<\/style>/i, "")

    render :layout => 'clean'

  end

  def portfolio

    if params[:id]
      if params[:mobile] == "true"
         @work = Work.find_by_name params[:id].gsub("-"," ")
        render :action => 'work' 
      else
         @work = Work.find params[:id]
        render :action => 'work' , :layout => false
      end
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

    begin
      Mailer.contact(first_name,last_name,email,message).deliver
      render :inline =>
         "Mail sended with success!"
    rescue Exception=>e
      render :inline =>
         "<span style=\"color: red;\">Mail sending error, have you typed the right address? </span>"
    end

  end

end
