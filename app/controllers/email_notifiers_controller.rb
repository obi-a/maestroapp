class EmailNotifiersController < ApplicationController
  before_filter :authenticate_user!
  def create
    flash[:success] = 'Successfully checked in'
    redirect_to :back
  end

  def update

  end

  def delete

  end
end
