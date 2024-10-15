import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["unitSelect", "resourceSelect"]  // Diese Target-Namen müssen gleich sein

  connect() {
    console.log('ResoureDataController controller connected');
    this.updateUnitSelect();
  }

  changeResource(event) {
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
}
