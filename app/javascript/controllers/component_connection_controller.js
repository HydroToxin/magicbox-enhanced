import NestedForm from "@stimulus-components/rails-nested-form"

export default class extends NestedForm {
  static targets = [
    "template",
    "target",
    "sourceComponent",
    "targetComponent",
    "sourceImage",
    "targetImage",
    "sourceReplacement",
    "targetReplacement",
    "addButton",
    "sourceComponentHidden",
    "targetComponentHidden",
  ]


  connect() {
    console.log("ComponentConnectionController connected")
    this.loadComponents()

  }

  add(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML
    const newIndex = new Date().getTime()
    const newContent = content.replace(/NEW_RECORD/g, newIndex)

    this.targetTarget.insertAdjacentHTML('beforebegin', newContent)
  }

  remove(event) {
    event.preventDefault()
    const row = event.target.closest('.component-connection-fields')

    const destroyInput = row.querySelector('input[name$="[_destroy]"]')
    if (destroyInput) {
      destroyInput.value = '1'
    }
    row.style.display = 'none'
  }

 async loadComponents() {
    try {
      const response = await fetch('/admin/components.json')
      this.components = await response.json()
    } catch (error) {
      console.error("Error loading components:", error)
    }
  }

  componentChanged(event) {
    event.preventDefault()

    const target = event.currentTarget;
    if (target === this.sourceComponentTarget) {
      this.updateSourceImage(event);
      this.sourceComponentHiddenTarget.value = this.sourceComponentTarget.value; // Update hidden field
    } else if (target === this.targetComponentTarget) {
      this.updateTargetImage(event);
      this.targetComponentHiddenTarget.value = this.targetComponentTarget.value; // Update hidden field
    }

    if (this.sourceComponentTarget.value && this.targetComponentTarget.value) {
      this.addButtonTarget.removeAttribute('disabled')
    } else {
      this.addButtonTarget.setAttribute('disabled', 'disabled')
    }

  }

  // Handler for source component selection
  updateSourceImage() {
    const componentId = parseInt(this.sourceComponentTarget.value)
    const component = this.components.find(c => c.id === componentId)

    if (component?.image_url) {
      this.sourceImageTarget.src = component.image_url
      this.sourceReplacementTarget.style.display = 'none';
    } else {
      this.sourceImageTarget.src = '';
      this.sourceReplacementTarget.style.display = 'block';
    }
  }

  // Handler for target component selection
  updateTargetImage() {
    const componentId = parseInt(this.targetComponentTarget.value)
    const component = this.components.find(c => c.id === componentId)

    if (component?.image_url) {
      this.targetImageTarget.src = component.image_url
      this.targetReplacementTarget.style.display = 'none';
    } else {
      this.targetImageTarget.src = '';
      this.targetReplacementTarget.style.display = 'block';
    }
  }
}