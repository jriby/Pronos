require 'spec_helper'

describe "NewUsers" do
  describe "GET /new_users" do
    it "should have a link in the listing users page to create a user" do
      visit users_path
      page.should have_link('New User' , :href => new_user_path)
    end
    it "should print the form to create a new user" do
      visit users_path
      click_link('New User')
      page.should have_content('Portail d\'inscription')
      page.should have_selector('form')
    end
  end
  describe "POST /users" do
    it "should create the user and print the user" do
      visit new_user_path
      fill_in('user[login]', :with => 'juliano')
      fill_in('user[passwd]', :with => 'pass')
      fill_in('validate_passwd', :with => 'pass')
      fill_in('user[nom]', :with => 'RIBY')
      fill_in('user[prenom]', :with => 'julien')
      fill_in('user[mail]', :with => 'jriby@lol.fr')
      click_button('Create')
      current_path.should == users_path
      page.should have_content('juliano')
    end
    it "should not create the user when info missing" do
      visit new_user_path
      fill_in('user[passwd]', :with => 'pass')
      fill_in('validate_passwd', :with => 'pass')
      fill_in('user[nom]', :with => 'RIBY')
      fill_in('user[prenom]', :with => 'julien')
      fill_in('user[mail]', :with => 'jriby@lol.fr')
      click_button('Create')
      page.should have_content('Portail d\'inscription')
      page.should have_content('login : can\'t be blank')
    end
  end
end
