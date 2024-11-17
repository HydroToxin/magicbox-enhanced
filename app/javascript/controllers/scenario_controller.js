import BaseFormController from "./base_nested_form_controller"

export default class extends BaseFormController {
  static targets = ["template", "target"]

  connect() {
    super.connect()
    console.log('ScenarioController connected.');

    if (typeof window.initBootstrapToggle === "function") {
      window.initBootstrapToggle();
    }
  }

  disconnect() {
    console.log('ScenarioController disconnected.');
  }
}
