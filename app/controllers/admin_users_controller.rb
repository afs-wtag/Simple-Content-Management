class AdminUsersController < ApplicationController
  layout 'admin'
  before_action :confirm_logged_in

  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    # instantiate a new object using foorm parameters
    @admin_user = AdminUser.new(admin_user_params)
    # save the admin
    if @admin_user.save
      flash[:notice] = 'Admin user was created successfully....'
      redirect_to(admin_users_path)
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    # Find a new object using foorm parameters
    @admin_user = AdminUser.find(params[:id])
    # save the subject
    if @admin_user.update(admin_user_params)
      flash[:notice] = 'Admin user was updated successfully.'
      redirect_to(admin_users_path) # if save succeeds,redirect to the index action
    else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    @admin_user = AdminUser.find(params[:id])
    @admin_user.destroy
    flash[:notice] = 'Admin user was killed successfully.'
    redirect_to(admin_users_path)
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(
      :first_name,
      :last_name,
      :email,
      :username,
      :password,
    )
  end
end
