class Public::PagesController < ApplicationController
  def show
    @page = Page.find_by(slug: params[:id])
    raise ActiveRecord::RecordNotFound unless @page
  end

  def about
    @page = Page.find_by(slug: 'about')
  end
end
