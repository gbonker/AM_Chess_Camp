class HomeController < ApplicationController
	
  def index
  	@available_camps = Camp.upcoming.active.chronological.select{ |camp| camp.registrations.size < camp.location.max_capacity }.take(10)
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
