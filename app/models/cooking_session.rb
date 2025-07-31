class CookingSession < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def start_step_timer(step, duration)
    TimerJob.perform_in(duration.seconds, id, step)
    broadcast_timer_update(step, duration)
  end

  private

  def broadcast_timer_update(step, duration)
    ActionCable.server.broadcast(
      "cooking_session_#{id}",
      {
        type: "timer_update",
        step: step,
        duration: duration,
        session_id: id
      }
    )
  end
end
