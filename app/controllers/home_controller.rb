class HomeController < ApplicationController
  def index
    redirect_to recruitments_path if account_signed_in?
  end
end
