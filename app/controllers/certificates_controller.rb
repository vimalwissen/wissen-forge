class CertificatesController < ApplicationController
  def show
    @badge = Badge.find(params[:badge_id])
    @user_badge = current_user.user_badges.find_by!(badge: @badge)
    render layout: false # Full screen certificate without nav
  end
end
