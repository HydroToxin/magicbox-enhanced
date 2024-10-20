class Admin::IssuesController < Admin::AdminController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /resource_datas/new
  def new
    @issue = Issue.new
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to admin_issue_datas_url, notice: 'Issue was successfully destroyed.' }
      format.turbo_stream { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def rissue_params
      params.require(:resource_data).permit()
    end

    def set_issue
    end
end
