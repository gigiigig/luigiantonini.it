require 'spec_helper'

describe Work do
  
  it "should have a valid factory" do
    FactoryGirl.create(:work).should be_valid
  end
  
  it "should be invalid without name" do
    FactoryGirl.build(:work , name: nil).should_not be_valid
  end

  it "should be invalid without description" do
    FactoryGirl.build(:work , description: nil).should_not be_valid
  end
  
  it "should be invalid without date" do
    FactoryGirl.build(:work , date: nil).should_not be_valid
  end
  
  
end
