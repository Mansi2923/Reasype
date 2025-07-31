class TimerJob
  include Sidekiq::Job
  
  def perform(session_id, step)
    session = CookingSession.find(session_id)
    
    ActionCable.server.broadcast(
      "cooking_session_#{session_id}",
      {
        type: 'timer_complete',
        step: step,
        message: 'Step completed!'
      }
    )
  end
end 