require 'spec_helper'

describe FrontController do

  describe "GET #index" do

    context "without paramaters " do

      before :each do
        get :index
      end

      describe "assigns" do
        it { should assign_to :technologies }
        it { should assign_to :works }
        it { should assign_to :contact }
      end

      describe "render" do
        it { should render_template :index }
        it { should render_with_layout :application }
      end

    end

    context "with param :layout => false" do

      describe "render" do

        it do
          get :index , :layout => 'false'
          should_not render_with_layout
        end

      end

    end

  end

  describe "GET #curriculum" do

    before do
      get :curriculum
    end

    it { should render_template :curriculum }
    it { should render_with_layout :clean }

  end

  describe "GET #portfolio" do

    context "without param :id" do

      before :each do
        get :portfolio
      end

      describe "assign" do
        it { should assign_to :works }
      end

      describe "render" do
        it { should render_template :portfolio }
        it { should_not render_with_layout }
      end

    end
    context "with param :id" do

      before :each do
        @work = FactoryGirl.create(:work)
        get :portfolio , id: @work.id                
      end

      describe "assign" do
        it { should assign_to :work }
      end

      describe "render" do
        it { should render_template :work }
        it { should_not render_with_layout }
      end

    end

  end

end
