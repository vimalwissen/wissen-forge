class ProfilesController < ApplicationController
  def show
    if params[:id]
      @user = User.find(params[:id])
      authorize @user, :show_profile?
    else
      @user = current_user
      # No authorize needed for own profile, or authorize @user, :show_profile? (which is always true for self)
    end
    
    @enrollments = @user.enrollments.order(completion_date: :desc)
    @badges = @user.badges
  end
end
