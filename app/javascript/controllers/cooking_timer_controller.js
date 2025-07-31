import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "timer", "step", "controls" ]
  static values = { sessionId: Number }
  
  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: "CookingSessionChannel", session_id: this.sessionIdValue },
      {
        received: (data) => {
          this.handleTimerUpdate(data)
        }
      }
    )
  }
  
  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }
  
  startTimer(event) {
    const duration = parseInt(event.target.dataset.duration)
    const step = parseInt(event.target.dataset.step)
    
    this.subscription.perform("start_timer", { step: step, duration: duration })
  }
  
  handleTimerUpdate(data) {
    if (data.type === 'timer_update') {
      this.displayTimer(data.duration)
      this.startCountdown(data.duration)
    }
  }
  
  startCountdown(duration) {
    let timeLeft = duration
    
    this.countdownInterval = setInterval(() => {
      timeLeft--
      this.displayTimer(timeLeft)
      
      if (timeLeft <= 0) {
        clearInterval(this.countdownInterval)
        this.showStepComplete()
      }
    }, 1000)
  }
  
  displayTimer(seconds) {
    const minutes = Math.floor(seconds / 60)
    const remainingSeconds = seconds % 60
    this.timerTarget.textContent = `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`
  }
  
  showStepComplete() {
    this.timerTarget.textContent = "Step Complete!"
    // Play notification sound, show visual alert, etc.
  }
} 