require 'spec_helper'
describe UsersController do
  describe "GET 'index'" do
    before(:each) do
      @users = [mock_model(User,:login => "log1"), mock_model(User, :login => "log2")]
      User.stub(:all){ @users }
    end
    it "assigns a list of users" do
      User.should_receive(:all).and_return(@users)
      get 'index'
      assigns(:users).should eq @users
    end

    it "renders the template list" do
      get 'index'
      response.should render_template(:index)
    end
  end
end
