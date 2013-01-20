require 'spec_helper'

describe Technology do

  describe "mass assignment" do

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :type }
    it { should allow_mass_assignment_of :image }

  end

  describe "validation" do

    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :type }

  end
  
  describe ":is_language" do
    
    it "should have the scope" do
      Technology.should respond_to(:is_language)
    end
    
    it "should show only Languges" do
      @lang = FactoryGirl.create(:technology , :type => "Language")
      Technology.is_language.should include(@lang)
    end
    
  end

end
