import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["unitSelect", "choiceSelect", "resourceSelect"]  // Diese Target-Namen müssen gleich sein

  connect() {
    console.log('ObservationResourceController connected');
    this.updateChoiceSelect();
    this.updateUnitSelect();
  }

  changeResource(event) {
    this.updateChoiceSelect();
    this.updateUnitSelect();
  }

  removeResource(event) {
    event.preventDefault();
    this.element.remove();
  }

  updateUnitSelect() {
    const resourceId = this.resourceSelectTarget.value;
    const resourceUnitsMap = JSON.parse(this.unitSelectTarget.dataset.unitsMap);

    const units = resourceUnitsMap[resourceId] || [];
    this.unitSelectTarget.innerHTML = '';

    units.forEach(unit => {
      const option = document.createElement("option");
      option.value = unit;
      option.textContent = unit;
      this.unitSelectTarget.appendChild(option);
    });
  }
  updateChoiceSelect() {
    const resourceId = this.resourceSelectTarget.value;
    const resourceChoicesMap = JSON.parse(this.choiceSelectTarget.dataset.choicesMap);

    const choices = resourceChoicesMap[resourceId] || [];
    this.choiceSelectTarget.innerHTML = '';

    choices.forEach(choice => {
      const option = document.createElement("option");
      option.value = choice;
      option.textContent = choice;
      this.choiceSelectTarget.appendChild(option);
    });
  }
}
