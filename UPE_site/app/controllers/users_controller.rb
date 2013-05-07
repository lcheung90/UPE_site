class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if params[:cancel_btn]
      redirect_to root_url and return
    end
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      reset_session
      session[:user_id] = @user.id
      redirect_to user_url(@user.username), :notice => "Thanks for signing up!  A confirmation email has been sent."
    else
      render "new"
    end
  end

  def show
    @user = User.find_by_username(params[:id])
    @questions = Question.find_all_by_user_id(@user.id)
    #@answers = Question.find_all_by_user_id(@user.id)
  end

  def edit
    @user = User.find_by_username(params[:id])
  end

  def update
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_tutor
    if @current_user.admin
    @user = User.find_by_username(params[:id])
      if @user.update_attribute(:tutor,params[:tutor])
        flash[:notice] = "The user "+@user.username+" has become a tutor"
      else
        flash[:notice] = "The user "+@user.username+" does not qualify as a tutor"
      end
    end
    redirect_to user_url(@user.username)
  end

  def revoke_tutor
   if @current_user.admin
    @user = User.find_by_username(params[:id])
      if @user.update_attribute(:tutor,params[:tutor])
        flash[:notice] = "The user "+@user.username+" has become a tutor"
      else
        flash[:notice] = "The user "+@user.username+" does not qualify as a tutor"
      end
    end
    redirect_to user_url(@user.username)
  end

  def set_admin
    if @current_user.admin
    @user = User.find_by_username(params[:id])
    #@self = User.find_by_username(@current_user)
    if @user.update_attribute(:admin,params[:admin]) && @current_user.update_attribute(:admin,false)
      flash[:notice] = "You have transfered your admin rights to "+@user.username
    else
      flash[:notice] = "You cannot transfer your admin rights to "+@user.username
    end
    redirect_to user_url(@user.username)
  end
end
end