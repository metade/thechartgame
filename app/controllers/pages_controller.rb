class PagesController < ApplicationController
  def index
    redirect_to predictions_path
  end
end
