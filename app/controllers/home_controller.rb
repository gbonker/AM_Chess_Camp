class HomeController < ApplicationController
	
  def index
  	#@available_camps = Camp.upcoming.active.chronological.to_a.select{ |camp| camp.registrations.size < camp.location.max_capacity }.take(10)
  	@empty_camps = Camp.upcoming.active.chronological.to_a.select{ |camp| camp.registrations.to_a.empty? }
    if current_user.nil? == false
  	  @upcoming_camps = current_user.instructor.camps.active.upcoming.chronological
      #@upcoming_students = current_user.instructor.camps.select{ |camp| @upcoming_camps.include? camp }.map{ |camp| camp.students }.flatten.to_a
  	end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
