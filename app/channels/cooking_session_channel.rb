class CookingSessionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cooking_session_#{params[:session_id]}"
  end
  
  def start_timer(data)
    session = CookingSession.find(params[:session_id])
    session.start_step_timer(data['step'], data['duration'])
  end
  
  def pause_timer
    # Handle timer pause
    ActionCable.server.broadcast(
      "cooking_session_#{params[:session_id]}",
      { type: 'timer_paused' }
    )
  end
  
  def next_step
    # Move to next cooking step
    session = CookingSession.find(params[:session_id])
    session.update(current_step: session.current_step + 1)
    
    ActionCable.server.broadcast(
      "cooking_session_#{params[:session_id]}",
      { 
        type: 'step_completed',
        current_step: session.current_step
      }
    )
  end
end 