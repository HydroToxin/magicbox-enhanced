import { Application } from "@hotwired/stimulus"
import ResourceDataController from "./resource_data_controller"

const application = Application.start()
application.register("resource-data", ResourceDataController)