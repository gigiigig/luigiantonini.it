class FrontController < ApplicationController
  def index
    @technology = Technology.first
  end
end
