require 'spec_helper'

describe "users/new" do
  it "renders new user form" do
    render
    rendered.should =~ /New user/
    rendered.should have_selector("form[action='/users']")
    rendered.should have_selector("input[name='user[login]']")
    rendered.should have_content('Login')
    rendered.should have_selector("input[name='user[passwd]']")
    rendered.should have_content('Mot de passe')
    rendered.should have_selector("input[name='validate_passwd']")
    rendered.should have_content('Mot de passe')
    rendered.should have_selector("input[name='user[nom]']")
    rendered.should have_content('Nom')
    rendered.should have_selector("input[name='user[prenom]']")
    rendered.should have_content('Prenom')
    rendered.should have_selector("input[name='user[mail]']")
    rendered.should have_content('Mail')
    rendered.should have_selector("input[type='submit']")
  end
end

