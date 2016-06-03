class Admin::ValuesController < Admin::AdminController
  before_action :set_value, only: [:show, :edit, :update, :destroy]
  before_action :set_category
  before_action :set_sensor

  def index
    @values = @sensor.values
  end

  def show
  end

  def new
    @value = Value.new
  end

  def edit
  end

  def create
    @value = Value.new(value_params)
    @value.sensor = @sensor

    respond_to do |format|
      if @value.save
        format.html { redirect_to admin_category_sensor_values_path(@category, @sensor), notice: 'Value was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @value.update(value_params)
        format.html { redirect_to admin_category_sensor_values_path(@category, @sensor), notice: 'Value was successfully updated.' }
      else
        format.html { render :edit }
      end
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
