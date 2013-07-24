require 'spec_helper'
describe UsersController do 
  describe 'listing user' do
    it "routes to #index" do 
      get('/users').should route_to("users#index")
    end
    it "should provide the aliast user_path for /users" do 
      users_path.should == '/users'
    end
  end
  describe 'new user' do
    it "routes to #new" do 
      get('/users/new').should route_to("users#new")
    end
    it "should provide the aliast new_user_path for /users/new" do
      new_user_path.should == '/users/new'
    end
    it "should routes to #create" do
      post('/users').should route_to("users#create")
    end
  end

  describe 'edit user' do
    it "routes to #index" do 
      get('/users/julien/edit').should route_to("users#edit", :id => "julien")
    end
  end
end
