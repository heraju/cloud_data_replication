class UserUploadsController < ApplicationController
  before_action :set_user_upload, only: [:show, :edit, :update, :destroy, :process_request, :download]

  respond_to :html

  def index
    if current_user.admin?
      @user_uploads = UserUpload.all
    else
      @user_uploads = current_user.user_uploads
    end
    respond_with(@user_uploads)
  end

  def show
    respond_with(@user_upload)
  end

  def new
    @user_upload = UserUpload.new
    respond_with(@user_upload)
  end

  def edit
  end

  def process_request
    @user_upload.fragments.destroy_all
    @file = @user_upload.process_request
    render action: 'show'
  end

  def download
    @start_time = Time.now
    @file = @user_upload.download(current_server)
    @end_time = Time.now
    @total_time = @end_time - @start_time
    @user_upload.post_download(current_server)
  end

  def create
    @user_upload =  UserUpload.new(user_upload_params)
    @user_upload.save
    @user_upload.process_request
    respond_with(@user_upload)
  end

  def update
    @user_upload.update(user_upload_params)
    respond_with(@user_upload)
  end

  def destroy
    @user_upload.destroy
    respond_with(@user_upload)
  end

  private
    def set_user_upload
      @user_upload = UserUpload.find(params[:id])
    end

    def user_upload_params
      params.require(:user_upload).permit(:user_id, :file, :rc_type).merge(node_id: current_server.id)
    end
end
