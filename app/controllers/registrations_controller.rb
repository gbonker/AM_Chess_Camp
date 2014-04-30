class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def new
  	@registration = Registration.new
    @registration.student_id = params[:student_id] unless params[:student_id].nil?
    @student = Student.find(params[:student_id]) unless params[:student_id].nil?
    @camps_qualified = Curriculum.for_rating(@student.rating).map{ |curriculum| curriculum.camps.active.upcoming }.flatten
      
    end
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to student_path(@registration.student), notice: "#{@registration.student.first_name} is now registered for #{@registration.camp.name}."
    else
      render action: 'new'
    end
  end

  def update
  	if @registration.update(registration_params)
      redirect_to student_path(@registration.student), notice: "#{@registration.student.first_name}'s registration for #{@registration.camp.name} was updated in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
  	student = @registration.student
  	@registration.destroy
    redirect_to student_path(@registration.student), notice: "#{@registration.student.first_name} is no longer registered for #{@registration.camp.name}."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end

end
