import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["", ""]

  connect() {
    console.log('ConditionGroupController connected.');
    if (typeof window.initBootrstrapToggle === "function") {
      window.initBootrstrapToggle();
    };
  }
}