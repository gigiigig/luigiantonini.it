require 'spec_helper'

describe Work do
  
  describe "validations" do
  
    it "should have a valid factory" do
      FactoryGirl.create(:work).should be_valid
    end
    
    it "should be invalid without name" do
      should validate_presence_of(:name) 
    end
  
    it "should be invalid without description" do
      should validate_presence_of(:description) 
    end
    
    it "should be invalid without date" do
      should validate_presence_of(:date) 
    end
    
  end
  
  describe "relations" do 
  
    it "should have many pictures" do
      #should 
    end
    
    it "should have one cover" do
      FactoryGirl.build(:work).should respond_to :cover
    end

  end
  
end
