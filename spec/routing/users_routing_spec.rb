require 'spec_helper'
describe UsersController do 
  it "routes to #index" do 
    get('/users').should route_to("users#index")
  end

  it "should provide the aliast user_path for /users" do 
    users_path.should == '/users'
  end
end
