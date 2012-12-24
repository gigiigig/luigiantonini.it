class Mailer < ActionMailer::Base
  default from: "luigi.antonini84@gmail.com"
  
  def contact(first_name, last_name , from , message)
    
    @first_name = first_name
    @last_name = last_name
    @from = from
    @message = message
    
    mail(:to => "luigi.antonini84@gmail.com", :from => from , 
         :subject => "Request from www.luigiantonini.it by user #{from}")
    
  end
  
end
