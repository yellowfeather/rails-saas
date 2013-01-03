class UsersController < TenantApplicationController

  def index
    @users = User.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
end
