require 'spec_helper'

describe "ListingUsers" do
  describe "GET /users" do
    before(:each) do
      @user1 = User.create(:login => "juliano", :passwd => "pass", :nom => "RIBY", :prenom => "julien", :mail => "jriby@axians.com", :valide => true, :points => 1)
      @user2 = User.create(:login => "Momow", :passwd => "password", :nom => "MORINEAU", :prenom => "paul", :mail => "pmomow@axians.com", :valide => true, :points =>0)
    end

    describe "GET /users" do
      it "generates a listing of users" do
        visit users_path
        page.should have_content @user1.login
        page.should have_content @user2.login
        page.should have_content @user1.nom
        page.should have_content @user2.nom
        page.should have_content @user1.prenom
        page.should have_content @user2.prenom
        page.should have_content @user1.mail
        page.should have_content @user2.mail


      end
    end
  end
end
