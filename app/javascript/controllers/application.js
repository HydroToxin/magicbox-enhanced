import { Application } from "@hotwired/stimulus"
import SidebarController from "./sidebar_controller"
import ResourceDataController from "./resource_data_controller"

const application = Application.start()
application.register("resource-data", ResourceDataController);
application.register("sidebar", SidebarController);