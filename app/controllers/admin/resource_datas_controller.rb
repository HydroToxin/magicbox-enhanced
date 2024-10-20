class Admin::ResourceDatasController < Admin::AdminController
  before_action :set_resource_data, only: [:show, :edit, :update, :destroy]

  # GET /resource_datas/new
  def new
    @resource_data = ResourceData.new
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @resource_data.destroy
    respond_to do |format|
      format.html { redirect_to admin_resource_datas_url, notice: 'Resource Data was successfully destroyed.' }
      format.turbo_stream { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_data_params
      params.require(:resource_data).permit()
    end

    def set_resource_data
    end
end
