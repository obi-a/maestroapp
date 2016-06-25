class EmailNotifiersController < ApplicationController
  before_filter :authenticate_user!
  def create
    notifier = current_user.email_notifiers.build(email: params[:email])
    if notifier.save
      flash[:info] = "The email address #{notifier.email} was successfully added. A verification email has been sent to this address. Follow the included instructions"
      AlertEmailVerificationJob.perform_later(
        notifier.id,
        verification_email_notifiers_url(token: notifier.verification_token),
        current_user.firstname
      )
    end
    redirect_to :back
  end

  def verification

  end

  def update

  end

  def delete

  end
end
