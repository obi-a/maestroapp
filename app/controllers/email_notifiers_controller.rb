class EmailNotifiersController < ApplicationController
  before_filter :authenticate_user!
  def create
    notifier = current_user.email_notifiers.build(email: params[:email])
    if notifier.save
      flash[:success] = "The email address #{notifier.email} was successfully added. A verification email has been sent to this address. Follow the included instructions"
      AlertEmailVerificationJob.perform_later(
        notifier.id,
        verification_email_notifiers_url(token: notifier.verification_token),
        current_user.firstname
      )
    end
    redirect_to :back
  end

  def verification
    notifier = current_user.email_notifiers.where(verification_token: params[:token]).first
    if notifier
      if ((Time.now - notifier.token_timestamp.to_time) / 1.hour).round < 3
        notifier.update_attribute(:verified, true)
        flash[:success] = "The email address #{notifier.email} has been successfully verified"
      else
        flash[:warning] = "The email address #{notifier.email} has could not be verified because the token has expired"
      end
    else
      flash[:alert] = "The email address could not be verified with the provided token"
    end
    redirect_to notifications_dashboard_index_path
  end

  def destroy
    notifier = current_user.email_notifiers.where(id: params[:id]).first
    if notifier
      n = notifier.destroy
      if n.destroyed?
        flash[:success] = "The alert email #{notifier.email} was successfully deleted"
      else
        flash[:alert] = "The are problems deleting the alert email"
      end
    else
      flash[:error] = "The are problems deleting the alert email"
    end
    redirect_to notifications_dashboard_index_path
  end
end
