class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_forum
     @forum =  Forum.find_by_id(params[:forum_id])
  end
  
end
