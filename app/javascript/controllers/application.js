import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// alert_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.dismiss()
    }, this.data.get("delay") || 3000)
  }

  dismiss() {
    this.element.style.transition = "opacity 0.3s"
    this.element.style.opacity = "0"
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
