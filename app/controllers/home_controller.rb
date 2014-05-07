class HomeController < ApplicationController
	
  def index
  	@available_camps = Camp.upcoming.active.chronological.select{ |camp| camp.registrations.size < camp.location.max_capacity }.take(10)
  	if current_user.nil? == false
  	  @upcoming_camps = current_user.instructor.camps.active.upcoming.chronological
  	end
    #@upcoming_students = current_user.instructor.camps.select{ |regi| @upcoming_camps.include? registration.camp }.students.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
