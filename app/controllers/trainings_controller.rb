class TrainingsController < ApplicationController
  before_action :set_training, only: %i[ show edit update ]

  def index
    @trainings = policy_scope(Training)
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
    @training.status = :published unless @training.mandatory? # Auto-publish non-mandatory
    authorize @training

    if @training.save
      redirect_to @training, notice: "Training was successfully created."
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
      redirect_to @training, notice: "Training updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_training
      @training = Training.find(params[:id])
    end

    def training_params
      params.require(:training).permit(:title, :description, :training_type, :mode, :start_time, :end_time, :capacity, :instructor, :department_target, :status)
    end
end
