import { Application } from "@hotwired/stimulus"
import SidebarController from "./sidebar_controller"
import NavbarController from "./navbar_controller"
import ObservationResourceController from "./observation_resource_controller"
import ObservationController from "./observation_controller"
import ScenarioController from "./scenario_controller"
import ConditionGroupController from "./condition_group_controller"
import ConditionController from "./condition_controller"
import ConditionFieldsController from "./condition_fields_controller"
import OperationController from "./operation_controller"
import RailsNestedForm from '@stimulus-components/rails-nested-form'
import ComponentController from "./component_controller"
import ComponentConnectionController from "./component_connection_controller"
import ComponentPinConnectionController from "./component_pin_connection_controller"
import DescriptionController from "./description_controller"
import ImagePreviewController from "./image_preview_controller"
import ImageUploadController from "./image_upload_controller"

const application = Application.start()
application.register("scenario", ScenarioController);
application.register("condition-group", ConditionGroupController);
application.register("condition", ConditionController);
application.register("condition-fields", ConditionFieldsController);
application.register("operation", OperationController);
application.register("observation-resource", ObservationResourceController);
application.register("observation", ObservationController);
application.register("sidebar", SidebarController);
application.register("navbar", NavbarController);
application.register('nested-form', RailsNestedForm)
application.register('component', ComponentController)
application.register('component-connection', ComponentConnectionController)
application.register('component-pin-connection', ComponentPinConnectionController)
application.register('description', DescriptionController)
application.register('image-preview', ImagePreviewController)
application.register('image-upload', ImageUploadController)

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