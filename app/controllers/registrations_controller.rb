class RegistrationsController < Devise::RegistrationsController
  def new
    if params[:plan]
      @signup = Forms::Signup.new
      @signup.plan = params[:plan]
      respond_with @signup
    else
      redirect_to pricing_path, :notice => 'Please select a subscription plan below'
    end
  end

  def create
    @signup = Forms::Signup.new(params[:forms_signup])

    if @signup.save
      if @signup.user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, @signup.user)
        respond_with @signup.user, :location => after_sign_up_path_for(@signup.user)
      else
        set_flash_message :notice, :"signed_up_but_#{@signup.user.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @signup.user, :location => after_inactive_sign_up_path_for(@signup.user)
      end
    else
      clean_up_passwords @signup.user
      render :action => "new"
    end
  end

end
