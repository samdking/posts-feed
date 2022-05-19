import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  like() {
    this.element.classList.toggle('bg-green-300')
  }
}