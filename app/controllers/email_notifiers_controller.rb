class EmailNotifiersController < ApplicationController
  before_filter :authenticate_user!
  def create
    notifier = EmailNotifier.new(email: params[:email])

    current_user.email_notifier.build(email: params[:email])
    flash[:success] = 'Successfully checked in'
    redirect_to :back
  end

  def update

  end

  def delete

  end
end
