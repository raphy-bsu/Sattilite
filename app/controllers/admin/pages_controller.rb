class Admin::PagesController < Admin::AdminController
  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    @page.update_attributes(page_params)
    redirect_to url_for([:edit, :admin, @page])
  end

  private
  def page_params
    params.require(:page).permit(:content, :title)
  end
end