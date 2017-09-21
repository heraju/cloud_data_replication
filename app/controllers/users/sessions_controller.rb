class Users::SessionsController < Devise::SessionsController
 before_filter :check_active, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  private

  def check_active
    user = User.find_by_email(params['user']['email'])
    if (user.nil? || !user.active?) && !user.admin?
      flash.now[:notice] = 'User Not Activated'
      redirect_to :back
    end
  end

end
