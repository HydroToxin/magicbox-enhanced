import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "template", "target" ]

  add(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML
    const newIndex = new Date().getTime()
    const newContent = content.replace(/NEW_RECORD/g, newIndex)

    this.targetTarget.insertAdjacentHTML('beforebegin', newContent)
  }

  remove(event) {
    event.preventDefault()
    const row = event.target.closest('.component-fields')

    const destroyInput = row.querySelector('input[name$="[_destroy]"]')
    if (destroyInput) {
      destroyInput.value = '1'
    }

    row.style.display = 'none'
  }
}