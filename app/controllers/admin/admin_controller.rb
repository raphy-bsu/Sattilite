class Admin::AdminController < ApplicationController
  layout 'admin'

  before_action :ensure_admin

  private

  def ensure_admin
    redirect_to root_url unless current_user.admin?
  end
end
