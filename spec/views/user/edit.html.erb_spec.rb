require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = stub_model(User, :login => "juliano", :pass => "pass", :nom => "RIBY", :prenom => "julien", :mail => "jrib@lol.fr" , :valide => 0)
    assign(:user, @user)
  end
  it "renders edit post form" do
    render
    rendered.should =~ /Edit user page/
    rendered.should have_selector("form[action='/users/#{@user.login}']")
    rendered.should have_selector("input[name='user[login]']")
    rendered.should have_selector("input[name='user[passwd]']")
    rendered.should have_selector("input[name='user[nom]']")
    rendered.should have_selector("input[name='user[prenom]']")
    rendered.should have_selector("input[name='user[mail]']")
    rendered.should have_selector("input[name='user[valide]']")
    rendered.should have_selector("input[type='submit']")
  end
end
