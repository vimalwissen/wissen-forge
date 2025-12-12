class ProfilesController < ApplicationController
  def show
    @user = current_user
    @enrollments = @user.enrollments.order(completion_date: :desc)
    @badges = @user.badges
  end
end
