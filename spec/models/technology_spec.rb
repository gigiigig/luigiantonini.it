require 'spec_helper'

describe Technology do

  describe "mass assignment" do

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :type }
    it { should allow_mass_assignment_of :image }
    it { should allow_mass_assignment_of :active }

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

  describe ":is_active" do
    
    it "should have the scope" do
      Technology.should respond_to(:is_active)
    end
    
    it "should show only active Technologies" do
      @tech_active = FactoryGirl.create(:technology)
      @tech_none_active = FactoryGirl.create(:technology , :active => false)

      Technology.is_language.should include(@tech_active)
      Technology.is_language.should_not include(@tech_not_active)

    end
    
  end

end
