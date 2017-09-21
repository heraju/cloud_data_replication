class DownloadsController < ApplicationController
  before_action :set_download, only: [:show, :edit, :update, :destroy, :approve]

  respond_to :html

  def index
    if current_user.admin?
      @downloads = Download.awaiting_approval
    else
      @downloads = current_user.downloads
    end
    respond_with(@downloads)
  end

  def show
    respond_with(@download)
  end

  def new
    @download = Download.new
    @uploads = UserUpload.all
    respond_with(@download)
  end

  def edit
  end

  def approve
    @download.update_attributes(apporve: true)
    if current_user.admin?
      @downloads = Download.awaiting_approval
    else
      @downloads = current_user.downloads
    end
    render 'index'
  end

  def create
    @download = Download.new(download_params)
    @download.save
    if current_user.admin?
      @downloads = Download.awaiting_approval
    else
      @downloads = current_user.downloads
    end
    render 'index'
  end

  def update
    @download.update(download_params)
    if current_user.admin?
      @downloads = Download.awaiting_approval
    else
      @downloads = current_user.downloads
    end
    render 'index'
  end

  def destroy
    @download.destroy
    respond_with(@download)
  end

  private
    def set_download
      @download = Download.find(params[:id])
    end

    def download_params
      params.require(:download).permit(:user_upload_id, :description).merge(user_id: current_user.id)
    end
end
