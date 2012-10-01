ActiveAdmin.register Work  do
  menu :label => "All" , :parent => "Works"
end

ActiveAdmin.register_page "Works Categories" do
  menu :label => "Categories" , :parent => "Works"
  
  content do
  end

end


