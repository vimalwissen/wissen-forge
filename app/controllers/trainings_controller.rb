class TrainingsController < ApplicationController
  before_action :set_training, only: %i[ show edit update ]

  def index
    @trainings = policy_scope(Training)

    if params[:skill].present?
      # Skills are stored as an array of strings in the DB
      @trainings = @trainings.where("? = ANY(skills)", params[:skill])
    end

    if params[:training_type].present?
      @trainings = @trainings.where(training_type: params[:training_type])
    end

    if params[:mode].present?
      @trainings = @trainings.where(mode: params[:mode])
    end
  end

  def show
    authorize @training
    @enrollment = current_user.enrollments.find_by(training: @training)
  end

  def new
    @training = Training.new
    authorize @training
  end

  def create
    @training = Training.new(training_params)
    
    # Approval logic:
    # - Super Admin created: Always auto-publish (no approval needed)
    # - Admin created mandatory training: Needs Super Admin approval
    # - Admin created non-mandatory training: Auto-publish
    if current_user.super_admin?
      @training.status = :published
    elsif @training.mandatory?
      @training.status = :pending_approval
    else
      @training.status = :published
    end
    
    authorize @training

    if @training.save
      # Auto-enroll users based on selected assignment options
      process_auto_enrollment(@training)
      
      if @training.pending_approval?
        redirect_to @training, notice: "Training created and sent for Super Admin approval."
      else
        redirect_to @training, notice: "Training was successfully created and published."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @training
  end

  def update
    authorize @training
    if @training.update(training_params)
      # Re-process enrollment if assignment details changed
      process_auto_enrollment(@training)
      redirect_to @training, notice: "Training details updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def publish
    @training = Training.find(params[:id])
    authorize @training
    
    @training.update(status: :published)
    redirect_to trainings_path, notice: "Training '#{@training.title}' has been published!"
  end

  # Show the assign form
  def assign
    @training = Training.find(params[:id])
    authorize @training, :update?
    
    @departments = User.distinct.pluck(:department).compact
    @employees = User.where(role: :employee).order(:name)
    @already_enrolled = @training.enrollments.pluck(:user_id)
  end

  # Bulk assign (enroll) users to training
  def assign_users
    @training = Training.find(params[:id])
    authorize @training, :update?
    
    enrolled_count = 0
    target_users = []
    
    case params[:assign_type]
    when "department"
      if params[:departments].present?
        target_users = User.where(department: params[:departments])
      end
    when "specific"
      if params[:user_ids].present?
        target_users = User.where(id: params[:user_ids])
      end
    end
    
    if target_users.empty?
      redirect_to assign_training_path(@training), alert: "Please select at least one department or user to assign."
      return
    end
    
    target_users.each do |user|
      unless @training.enrollments.exists?(user: user)
        if @training.enrollments.create(user: user, status: :enrolled)
          enrolled_count += 1
        end
      end
    end
    
    if enrolled_count > 0
      redirect_to @training, notice: "Successfully enrolled #{enrolled_count} user(s) in '#{@training.title}'."
    else
      redirect_to @training, alert: "Selected users are already enrolled."
    end
  rescue => e
    Rails.logger.error("Assignment Error: #{e.message}")
    redirect_to assign_training_path(@training), alert: "An error occurred during assignment: #{e.message}"
  end

  private
    def set_training
      @training = Training.find(params[:id])
    end

    def training_params
      # Handle skills as comma-separated string from form
      if params[:training][:skills].is_a?(String)
        params[:training][:skills] = params[:training][:skills].split(",").map(&:strip).reject(&:blank?)
      end
      
      params.require(:training).permit(:title, :description, :training_type, :mode, :start_time, :end_time, :capacity, :instructor, :department_target, :status, :assignment_scope, target_departments: [], target_user_ids: [], skills: [])
    end

    def process_auto_enrollment(training)
      users_to_enroll = []
      
      if training.assign_department? && training.target_departments.present?
        # Remove empty strings from array (Rails form handling artifact)
        departments = training.target_departments.reject(&:blank?)
        if departments.any?
          users_to_enroll = User.where(department: departments)
        end
      elsif training.assign_specific? && training.target_user_ids.present?
        # Remove empty and nil values
        user_ids = training.target_user_ids.reject(&:blank?)
        if user_ids.any?
          users_to_enroll = User.where(id: user_ids)
        end
      end

      # Enroll users
      users_to_enroll.each do |user|
        unless training.enrollments.exists?(user: user)
          training.enrollments.create(user: user, status: :enrolled)
        end
      end
    end
end
