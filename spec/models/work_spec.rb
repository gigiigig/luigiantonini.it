require 'spec_helper'

describe Work do

  describe "mass assignment" do

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :date }
    it { should allow_mass_assignment_of :link }
    it { should allow_mass_assignment_of :cover }
    it { should allow_mass_assignment_of :pictures_attributes }
    

  end

  describe "validations " do

    it "should have a valid factory" do
      FactoryGirl.create(:work).should be_valid
    end

    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :date }

  end

  describe "relations" do

    it { should have_many :pictures }
    it { should accept_nested_attributes_for :pictures }
  
    it "should have one cover" do
      FactoryGirl.build(:work).should respond_to :cover
    end

  end

end
