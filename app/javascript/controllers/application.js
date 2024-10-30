import { Application } from "@hotwired/stimulus"
import SidebarController from "./sidebar_controller"
import ObservationResourceController from "./observation_resource_controller"
import ObservationController from "./observation_controller"

const application = Application.start()
application.register("observation-resource", ObservationResourceController);
application.register("observation", ObservationController);
application.register("sidebar", SidebarController);