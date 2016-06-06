class Admin::ValuesController < Admin::AdminController
  before_action :set_value, only: [:show, :edit, :update, :destroy]
  before_action :set_category
  before_action :set_sensor

  def index
    from =  params[:from].present? ? params[:from].to_datetime.to_i : 0
    to = params[:to].present? ? params[:to].to_datetime.to_i : Time.now.to_i
    unpagindated = @sensor.values.where('time > ?', from).where('time < ?', to)
    @values = unpagindated.paginate(:page => params[:page], :per_page => 30)
    respond_to do |format|
      format.html
      format.csv  { render csv: unpagindated, only: [], add_methods: [:formatted_time, :get_value] }
    end
  end

  def destroy
    @value.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_sensor_values_path(@category, @sensor), notice: 'Value was successfully destroyed.' }
    end
  end

  def destroy_all
    @sensor.values.destroy_all
    respond_to do |format|
      format.html { redirect_to admin_category_sensor_values_path(@category, @sensor), notice: 'Value was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_value
      @value = Value.find(params[:id])
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_sensor
      @sensor = @category.sensors.find(params[:sensor_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def value_params
      params.require(:value).permit(:val_float, :val_int, :val_str, :val_bool, :sensor_id, :time)
    end
end
