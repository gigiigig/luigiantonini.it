class FrontController < ApplicationController
  def index
    @technology = Technology.first
    @work = Work.first
  end
end
