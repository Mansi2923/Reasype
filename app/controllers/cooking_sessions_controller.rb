class CookingSessionsController < ApplicationController
  def create
    # For now, just return success
    render json: { 
      success: true, 
      message: "Cooking session created successfully" 
    }
  end
  
  def show
    # For now, just return session info
    render json: { 
      success: true, 
      message: "Cooking session details would be shown here" 
    }
  end
end 