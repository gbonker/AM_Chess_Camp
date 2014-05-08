class HomeController < ApplicationController
	
  def index
  	@available_camps = Camp.upcoming.active.chronological.to_a.select{ |camp| camp.registrations.size < camp.location.max_capacity }.take(10)
  	@empty_camps = Camp.upcoming.active.chronological.to_a.select{ |camp| camp.registrations.to_a.empty? }
    @instructorless_camps = Camp.upcoming.active.chronological.to_a.select{ |camp| camp.instructors.to_a.empty? }
    @registrationless_students = Student.active.alphabetical.to_a.select{ |student| student.registrations.to_a.empty? }
    if current_user.nil? == false
  	  @upcoming_camps = current_user.instructor.camps.active.upcoming.chronological
      @upcoming_students = current_user.instructor.camps.chronological.select{ |camp| @upcoming_camps.include? camp }.map{ |camp| camp.students.alphabetical }.flatten.to_a
      @instructor = current_user.instructor
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
