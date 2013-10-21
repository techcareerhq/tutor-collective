class SessionsController < ApplicationController
  def new
  end

  # POST /sessions
	def create
	  tutor = Tutor.authenticate params[:email], params[:password]
	    if tutor
	      session[:tutor_id] = tutor.id
	      redirect_to root_path, :notice => "Welcome back to TutorCollective"
	    else
	      redirect_to :login, :alert => "Invalid email or password"
	    end
	end

	def destroy
	  session[:tutor_id] = nil
	  redirect_to root_path :notice => "You have been logged out"
	end
	
end
