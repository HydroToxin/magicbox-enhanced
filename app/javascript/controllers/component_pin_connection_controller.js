import NestedForm from "@stimulus-components/rails-nested-form"

export default class extends NestedForm {
  static targets = [
    "template",
    "target",
    "sourceControlPin",
    "targetControlPin",
    "removeButton"
  ]

  connect() {
    console.log("ComponenrPinConnectionController connected")
  }

  add(event) {
    console.log("add clicked")
    event.preventDefault()
    const content = this.templateTarget.innerHTML
    const newIndex = new Date().getTime()
    const newContent = content.replace(/NEW_RECORD/g, newIndex)

    this.targetTarget.insertAdjacentHTML('beforebegin', newContent)

    const sourceComponent = document.querySelector('[data-component-connection-target="sourceComponent"]');
    const targetComponent = document.querySelector('[data-component-connection-target="targetComponent"]');
    const sourceControlPins = document.querySelectorAll('[data-component-pin-connection-target="sourceControlPin"]');
    const targetControlPins = document.querySelectorAll('[data-component-pin-connection-target="targetControlPin"]');
    const lastSourceControlPins = sourceControlPins[sourceControlPins.length - 1];
    const lastTargetControlPins = targetControlPins[targetControlPins.length - 1];

    const selectedSourceOption = sourceComponent.options[sourceComponent.selectedIndex];
    const selectedTargetOption = targetComponent.options[targetComponent.selectedIndex];
    const selectedSourceId = selectedSourceOption ? selectedSourceOption.value : null;
    const selectedTargetId = selectedTargetOption ? selectedTargetOption.value : null;

    sourceComponent.setAttribute('disabled', 'disabled')
    targetComponent.setAttribute('disabled', 'disabled')


    this.handlePinChange(lastSourceControlPins, selectedSourceId)
    this.handlePinChange(lastTargetControlPins, selectedTargetId)
  }

  remove(event) {
    event.preventDefault()
    const row = event.target.closest('.component-pin-connection-fields')

    if (row.dataset.newRecord === 'true') {
      row.remove();
    } else {
      row.querySelector('input[name*="_destroy"]').value = 1;
      row.style.display = 'none';
    }

    const removeButtons = document.querySelectorAll('[data-component-pin-connection-target="removeButton"]');

    if(removeButtons.length === 0) {
      const sourceComponent = document.querySelector('[data-component-connection-target="sourceComponent"]');
      const targetComponent = document.querySelector('[data-component-connection-target="targetComponent"]');
      sourceComponent.removeAttribute('disabled')
      targetComponent.removeAttribute('disabled')
    }
  }

  handlePinChange(target, componentId) {
    this.promptToRemoveExistingPins(target, () => {
      this.updatePins(componentId, target);
      this.clearPinFields(target);
    });
  }

  updatePins(componentId, pinsTarget) {
    if (!componentId) return;

    fetch(`/admin/components/${componentId}.json`)
      .then(response => response.json())
      .then(data => {
        pinsTarget.innerHTML = data.control_pins.map(pin => `<option value="${pin.id}">Pin ${pin.pin_number} - ${pin.name}</option>`).join('');
      })
      .catch(error => console.error('Error fetching pins:', error));
  }

  clearPinFields(pinFieldsTarget) {
    // Remove existing pin fields
    while (pinFieldsTarget.firstChild) {
      pinFieldsTarget.removeChild(pinFieldsTarget.firstChild);
    }
  }

  promptToRemoveExistingPins(pinFieldsTarget, callback) {
    // Check if there are existing pins
    const existingPins = pinFieldsTarget.querySelectorAll('.component-pin-connection-fields');
    if (existingPins.length > 0) {
      // Prompt the user to confirm removal of existing pins
      if (confirm('Existing pins will be removed. Do you want to proceed?')) {
        callback();
      }
    } else {
      callback();
    }
  }

}