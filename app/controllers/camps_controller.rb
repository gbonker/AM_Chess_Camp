class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    @past_camps = Camp.past.chronological.paginate(:page => params[:page]).per_page(10)
    @inactive_camps = Camp.inactive.alphabetical.to_a
  end

  def show
    @instructors = @camp.instructors.alphabetical.to_a
    @registrations = @camp.registrations.by_student.to_a
    @registration = Registration.new
    @registrations_remaining = @camp.max_students - @registrations.size
    
    @total_balances_due = @camp.registrations.select{ |registration| registration.payment_status == "deposit" }.size * (@camp.cost - 50)
    
    @total_deposit_payments = @camp.registrations.select{ |registration| registration.payment_status == "deposit" }.size * (50)
    @total_full_payments = @camp.registrations.select{ |registration| registration.payment_status == "full" }.size * (@camp.cost)
    @total_payments_received = @total_deposit_payments + @total_full_payments
  end

  def new
    @camp = Camp.new
  end

  def edit
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to @camp, notice: "The camp #{@camp.name} (on #{@camp.start_date.strftime('%m/%d/%y')}) was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @camp.update(camp_params)
      redirect_to @camp, notice: "The camp #{@camp.name} (on #{@camp.start_date.strftime('%m/%d/%y')}) was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @camp.destroy
    redirect_to camps_url, notice: "#{@camp.name} camp on #{@camp.start_date.strftime('%m/%d/%y')} was removed from the system."
  end

  private
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active, :instructor_ids => [])
    end
end
