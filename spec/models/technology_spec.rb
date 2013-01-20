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
    
  end

end
