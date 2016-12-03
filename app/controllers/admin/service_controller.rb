class Admin::ServiceController < Admin::AdminController
  def index
    @values_count = Value.all.size
    @values_limit = Value::LIMIT
  end

  def destroy_all_values
    Value.destroy_all
    respond_to do |format|
      format.html { redirect_to admin_service_index_path, notice: 'Values were successfully destroyed.' }
    end
  end
end
