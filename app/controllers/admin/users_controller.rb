class Admin::UsersController < Admin::AdminController
  def index
    @users = User.where.not(email: 'admin@example.com')
  end

  def new

  end

  def create

  end

  def destroy

  end

  def edit

  end
end
