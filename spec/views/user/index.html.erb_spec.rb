require 'spec_helper'
describe "users/index.html.erb" do
  it "displays all the users" do
    assign(:users, [
           stub_model(User, :login => "login 1", :nom => "RIBY", :prenom => "julien", :mail => "jriby@axians.com", :points => 111),
           stub_model(User, :login => "login 2", :nom => "LOLI", :prenom => "Lol", :mail => "lol@lol.lol", :points => 222 )
          ])
    render
    rendered.should =~ /login 1/
    rendered.should =~ /login 2/
    rendered.should =~ /RIBY/
    rendered.should =~ /julien/
    rendered.should =~ /jriby@axians.com/
    rendered.should =~ /LOLI/
    rendered.should =~ /Lol/
    rendered.should =~ /lol@lol.lol/
    rendered.should =~ /111/
    rendered.should =~ /222/



  end
end
