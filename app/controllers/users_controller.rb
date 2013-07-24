class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @user = User.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @user = User.new(:login => params[:user][:login], :passwd => params[:user][:passwd], :nom => params[:user][:nom], :prenom => params[:user][:prenom], :mail => params[:user][:mail])    
    if validate_passwd?(params[:user][:passwd],params[:validate_passwd]) && @user.save
      flash[:notice] = 'Utillisateur créé avec succès. Veuillez attendre le mail de confirmation'
      respond_to do |format|
        format.html { redirect_to(users_path) }
        format.json { redirect_to(users_path) }
        format.js # new.js.erb
        end
    else
      @error = @user.errors.messages
      if !validate_passwd?(params[:user][:passwd],params[:validate_passwd])
        @error_passwd = "Veuillez rentrer deux mdp indentiques" 
      end           
       render new_users_path
    end
  end
end
