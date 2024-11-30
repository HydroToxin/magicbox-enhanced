import flatpickr from 'flatpickr';
import BaseNestedFormController from "./base_nested_form_controller"

export default class extends BaseNestedFormController {
  static targets = [
    "conditionType",
    "dateFields",
    "durationFields",
    "dataTypeFields",
    "deviceFields",
    "predicateField",
    "targetValueField"
  ]

  connect() {
    super.connect()
    console.log("ConditionFieldsController connected")

    if (this.hasConditionTypeTarget) {
      if (!this.conditionTypeTarget.value) {
        this.conditionTypeTarget.value = "date"
      }
      this.showSelectedForm(this.conditionTypeTarget.value)
    } else {
      console.error("conditionType target not found!")
    }
  }

  disconnect() {
    // Falls nötig für cleanup
  }

  remove(event) {
    event.preventDefault();
    let item = event.target.closest('.condition-fields');
    if (item.dataset.newRecord === 'true') {
      item.remove();
    } else {
      item.querySelector('input[name*="_destroy"]').value = 1;
      item.style.display = 'none';
    }
  }

  changeConditionType(event) {
    this.showSelectedForm(event.target.value)
  }

  showSelectedForm(type) {
    this.hideAllFields()

    const displayConfig = {
      'date': ['dateFields'],
      'time_duration': ['durationFields'],
      'data_type': ['dataTypeFields', 'predicateField', 'targetValueField'],
      'device_state': ['deviceFields', 'predicateField', 'targetValueField']
    }

    displayConfig[type]?.forEach(targetName => {
      const target = this[`${targetName}Target`]
      target.classList.remove('condition__field--hidden')
      target.classList.add('condition__field--visible')
    })
  }

  hideAllFields() {
    [
      this.dateFieldsTarget,
      this.durationFieldsTarget,
      this.dataTypeFieldsTarget,
      this.deviceFieldsTarget,
      this.predicateFieldTarget,
      this.targetValueFieldTarget
    ].forEach(element => {
      element.classList.add('condition__field--hidden')
      element.classList.remove('condition__field--visible')
    })
  }
}
