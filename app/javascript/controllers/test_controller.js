import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Test controller connected!")
    this.element.textContent = "Test controller is working!"
  }
} 