class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def settings
  end
end
