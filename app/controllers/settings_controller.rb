class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @settings = Setting.all
    respond_with(@settings)
  end

  def show
    respond_with(@setting)
  end

  def new
    @setting = Setting.new
    respond_with(@setting)
  end

  def edit
  end

  def user_activation
    @users = User.all
  end

  def activate_user
    user = User.find(params[:id])
    user.update_attributes(active: true)
    @users = User.all
    flash.now[:notice] = 'User Activated'
    render 'user_activation'
  end

  def dectivate_user
    user = User.find(params[:id])
    user.update_attributes(active: false)
    @users = User.all
    flash.now[:notice] = 'User De-Activated'
    render 'user_activation'
  end

  def create
    @setting = Setting.new(setting_params)
    @setting.save
    respond_with(@setting)
  end

  def update
    @setting.update(setting_params)
    respond_with(@setting)
  end

  def destroy
    @setting.destroy
    respond_with(@setting)
  end

  def change_server
    @servers = Node.all
  end

  def new_change_server
    session[:server_id] = params[:server_id]
    flash.now[:notice] = 'New Server updated'
    redirect_to :back
  end

  def clear_data
    UserUpload.all.destroy_all
    Download.all.destroy_all
    redirect_to :back
  end

  def drpa_cache
    drpa_fragments = UserUpload.where(rc_type: 2)
    if drpa_fragments
      drpa_fragments.each do |user_upload|
        user_upload.create_drpa_cache
      end
      flash.now[:notice] = 'DRPA Cache Created' unless drpa_fragments.empty?
    else
      flash.now[:notice] = 'DRPA Not Found' unless drpa_fragments.empty?
    end
    @settings = Setting.all
    render action: 'index'
  end

  private
    def set_setting
      @setting = Setting.find(params[:id])
    end

    def setting_params
      params.require(:setting).permit(:node_count, :fragment_size)
    end
end
