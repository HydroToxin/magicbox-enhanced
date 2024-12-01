import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["functionSelect", "description"]

  connect() {
    console.log('DescriptionFormController connected.');
    this.descriptions = JSON.parse(this.element.dataset.descriptions);
    this.updateDescription();
  }

  updateDescription() {
    const selectedValue = this.functionSelectTarget.value;
    this.descriptionTarget.textContent = this.descriptions[selectedValue] || 'No description available';
  }
}