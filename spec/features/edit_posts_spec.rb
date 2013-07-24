require 'spec_helper'

describe "EditPosts" do
  before(:each) do
    @user = User.create(:login => "juliano", :passwd => "pass", :nom => "RIBY", :prenom => "Julien", :mail => "jriby@axians.com", :valide => false)
  end
  it "should have a link in the listing user page to edit a user" do
    visit users_path
    page.should have_link('Edit', :href => edit_user_path(@user.login))
  end

  it "should print the form to edit a new post" do
    visit edit_user_path(@user.login)
    page.should have_content('Edit user page')
    page.should have_selector('form')
  end

  it "should update the post and print the posts" do
    visit edit_user_path(@user.login)
    fill_in('user[prenom]', :with => 'julienchange')
    check('user[valide]', :checked)
    click_button('Update')
    current_path.should == users_path
    page.should have_content('julienchange')
    page.should have_content(true)
    page.should have_content('julien')
  end
end
