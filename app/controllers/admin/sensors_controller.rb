class Admin::SensorsController < Admin::AdminController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]
  before_action :set_category

  def index
    @sensors = @category.sensors
  end

  def show
  end

  def new
    @sensor = Sensor.new
  end

  def edit
  end

  def create
    @sensor = Sensor.new(sensor_params)
    @sensor.abbr = @sensor.name.parameterize if @sensor.abbr.empty?
    @sensor.category = @category

    respond_to do |format|
      if @sensor.save
        format.html { redirect_to admin_category_sensors_url(@category), notice: 'Sensor was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to admin_category_sensors_url(@category), notice: 'Sensor was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @sensor.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_sensors_url(@category), notice: 'Sensor was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor).permit(:name, :abbr, :category_id, :val_type, :measure)
    end
end
