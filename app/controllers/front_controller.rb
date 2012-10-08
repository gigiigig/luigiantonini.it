class FrontController < ApplicationController
  def index
    
    @technology = Technology.first
    @work = Work.first
    
    2.times do
      @work.pictures.build
    end
    
  end
end
