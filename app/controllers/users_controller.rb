class UsersController < ApplicationController

  before_filter :user_exist, :except => [:index, :new ,:create]

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(:login => params[:user][:login], :passwd => params[:user][:passwd], :nom => params[:user][:nom], :prenom => params[:user][:prenom], :mail => params[:user][:mail])    
    if validate_passwd?(params[:user][:passwd],params[:validate_passwd]) && @user.save
      flash[:notice] = 'Utillisateur créé avec succès. Veuillez attendre le mail de confirmation'
      redirect_to users_path
    else
      @error = @user.errors.messages
      if !validate_passwd?(params[:user][:passwd],params[:validate_passwd])
        @error_passwd = "Veuillez rentrer deux mdp indentiques" 
      end           
       render new_user_path
    end
  end

  def edit
    @user = User.find_by_login(params[:id])
  end


end
