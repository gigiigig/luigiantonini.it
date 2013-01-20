require 'spec_helper'

describe Picture do
  
  describe ":image" do
    
    it { should respond_to :image }
    it { should allow_mass_assignment_of :image }
    
  end
  
  describe "relationa" do
    
    it { should belong_to :imageable }
    
  end
  
end
