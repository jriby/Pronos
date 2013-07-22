require 'spec_helper'

describe User do

before(:each) do
  @u=User.new()
end 

context "init" do
 describe "Without info missing" do
    it "should be valid with a login passwd nom prenom mail" do
      @u.login = "jfunt"
      @u.passwd = "pass"
      @u.nom = "nom"
      @u.prenom = "prenom"
      @u.mail = "nom.prenom@coucou.fr"
      @u.should be_valid
    end
  end

  describe "With info missing" do
  before do
    @u.login = "jfunt"
    @u.passwd = "pass"
    @u.nom = "nom"
    @u.prenom = "prenom"
    @u.mail = "nom.prenom@coucou.fr"
  end

    it "should not be valid without a passwd" do
      @u.passwd = nil	
      @u.should_not be_valid
    end

    it "should not be valid without a login" do
      @u.login = nil
      @u.should_not be_valid
    end

    it "should not be valid if the login is empty" do
      @u.login = ""	
      @u.should_not be_valid
    end

    it "should not be valid if the passwd is empty" do
      @u.passwd = ""	
      @u.should_not be_valid
    end
  end
end


describe "Unicity" do
  it "should have a login unique" do
    @params1 = { 'user' => {"login" => "jriby", "passwd" => "pass", "nom" => "nom", "prenom" => "prenom", "mail" => "j@lol.fr" }}
    @params2 = { 'user' => {"login" => "jriby", "passwd" => "pass1", "nom" => "nom", "prenom" => "prenom1", "mail" => "j1@lol.fr" }}
    @u1 = User.create(@params1['user'])
    @u2 = User.create(@params2['user'])
    @u2.valid?
    @u2.errors.messages[:login].include?("has already been taken").should be_true
  end
  it "should have a mail unique" do
    @params1 = { 'user' => {"login" => "jriby", "passwd" => "pass", "nom" => "nom", "prenom" => "prenom", "mail" => "j@lol.fr" }}
    @params2 = { 'user' => {"login" => "jgoin", "passwd" => "pass1", "nom" => "nom", "prenom" => "prenom1", "mail" => "j@lol.fr" }}
    @u1 = User.create(@params1['user'])
    @u2 = User.create(@params2['user'])
    @u2.valid?
    @u2.errors.messages[:mail].include?("has already been taken").should be_true
  end
end
describe "Tests of methods" do
  describe "Test passwd" do

    before(:each) do
      @u = User.new
      @u.login = "jriby"
    end

    it "Should call the encryption sha1" do

      Digest::SHA1.should_receive(:hexdigest).with("pass").and_return("ok")
      @u.passwd = "pass"
      @u.passwd.should == "\"ok\""
    end

    it "Should encrypt the pass" do

      @u.passwd = "pass"
      @u.passwd.should == "\"9d4e1e23bd5b727046a9e3b4b7db57bd8d6ee684\""
    end

  end

  describe "Test of method present?" do
  before do
    @params = { 'user' => {"login" => "jgoin", "passwd" => "pass", "nom" => "nom", "prenom" => "prenom", "mail" => "j@lol.fr" }}
  end

    it "Should use find_by_login" do
      User.should_receive(:find_by_login).with('jriby')
      User.present?('jriby', 'pass')
    end

    it "Should return true if the user is present" do
      @user = User.create(@params['user'])
      User.present?('jgoin', 'pass').should be_true
      @user.destroy
    end

    context "will return false"

      it "Should not be valid if the user is not present" do
        User.present?('looool', 'pass').should be_false
      end

       it "Should not be valid if the pass is bad" do
        User.present?('jgoin', 'badpassword').should be_false
      end

      it "Should not be valid if the user is not given" do
        User.present?(nil, 'pass').should be_false
      end

      it "Should not be valid if the pass is not given" do
        User.present?('looool', nil).should be_false
      end

      it "Should not be valid if the login and the pass is not given" do
        User.present?(nil, nil).should be_false
      end
  end

end

end
