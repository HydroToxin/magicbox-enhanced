import { Application } from "@hotwired/stimulus"
import SidebarController from "./sidebar_controller"
import NavbarController from "./navbar_controller"
import ObservationResourceController from "./observation_resource_controller"
import ObservationController from "./observation_controller"
import ScenarioFormController from "./scenario_form_controller"
import ConditionGroupFormController from "./condition_group_form_controller"
import ConditionFormController from "./condition_form_controller"
import ConditionFormFieldsController from "./condition_form_fields_controller"
import OperationFormController from "./operation_form_controller"
import RailsNestedForm from '@stimulus-components/rails-nested-form'

const application = Application.start()
application.register("scenario-form", ScenarioFormController);
application.register("condition-group-form", ConditionGroupFormController);
application.register("condition-form", ConditionFormController);
application.register("condition-form-fields", ConditionFormFieldsController);
application.register("operation-form", OperationFormController);
application.register("observation-resource", ObservationResourceController);
application.register("observation", ObservationController);
application.register("sidebar", SidebarController);
application.register("navbar", NavbarController);
application.register('nested-form', RailsNestedForm)

document.addEventListener('DOMContentLoaded', function () {
  window.initBootrstrapToggle = initBootrstrapToggle;
});

const initBootrstrapToggle = function() {
  console.log('initBootrstrapToggle');
  const checkboxes = document.querySelectorAll('input[type=checkbox][data-toggle="toggle"]');
  checkboxes.forEach((ele) => {
    if (typeof ele.bootstrapToggle === 'function') {
      ele.bootstrapToggle();
    } else {
      console.warn('Bootstrap toggle method is not defined.');
    }
  });
}