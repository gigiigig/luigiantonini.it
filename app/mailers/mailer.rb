class Mailer < ActionMailer::Base
  default from: "luigi.antonini84@gmail.com"
  
  def contact(first_name, last_name , from , message)
    
    mail(:to => "luigi.antonini84@gmail.com", :from => from , :subject => 
    "
    Contact from LuigiAntonini.it\n
    user : #{first_name} #{last_name}\n
    email : #{from}\n
    message : #{message}\n
    ")
    
  end
  
end
