class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    if user.role? :admin
        can :manage, :all
    elsif user.role? :instructor
        can :index, [Instructor, Location, Curriculum, Camp]
        can :show, [Camp, Instructor, Location, Curriculum]

        can :read, Student do |this_student|  
            instructor_students = user.instructor.camps.map{|c| c.students.map(&:id)}.flatten
            instructor_students.include? this_student.id 
        end
        can :show, Student do |this_student|  
            instructor_students = user.instructor.camps.map{|c| c.students.map(&:id)}.flatten
            instructor_students.include? this_student.id 
        end

        can :read, Instructor do |instructor|
            instructor.id == user.instructor_id
        end
        can :update, Instructor do |instructor|  
            instructor.id == user.instructor_id
        end
        can :update, User do |user|
            user.id == instructor.user.id
        end
        can :edit, Instructor do |instructor|  
            instructor.id == user.instructor_id
        end
        can :edit, User do |user|
            user.id == instructor.user.id
        end
    else # guest
        can :read, [Camp, Instructor, Curriculum, Location]
        can :index, [Instructor, Location, Curriculum, Camp]
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
