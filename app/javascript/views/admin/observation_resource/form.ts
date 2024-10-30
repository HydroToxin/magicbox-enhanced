import { StreamActions } from "@hotwired/turbo"

function initAdminObservationResourceForm() {
  // Check if the form with the specific ID is present in the DOM
  const adminObservationResourceForm = document.getElementById("admin-observation-resource-form") as HTMLFormElement | null;
  if (!adminObservationResourceForm) {
    return; // Exit the function if the form is not present
  }

  const resourceSelect = document.getElementById('resource-select') as HTMLSelectElement;
  const unitSelect = document.getElementById('unit-select') as HTMLSelectElement;

  // Directly using the embedded JSON data for resources and units
  const resourceUnitsMap = (window as any).resourceUnitsMap;

  console.log(resourceUnitsMap)
  console.log(resourceSelect);
  console.log(unitSelect);

  // Initial load with the selected (or first) resource's units
  if (resourceSelect.value) {
    updateUnitOptions(resourceSelect.value);
  } else if (Object.keys(resourceUnitsMap).length > 0) {
    // Fallback if no initial selection is made, use first available
    updateUnitOptions(Object.keys(resourceUnitsMap)[0]);
  }

  // Update units when selection changes
  resourceSelect.addEventListener('change', () => {
    console.log('Resource changed:', resourceSelect.value);
    updateUnitOptions(resourceSelect.value);
  });

  function updateUnitOptions(resourceId: string | undefined) {
    if (!resourceId) {
      console.error("resourceId is undefined");
      return;
    }

    console.log("Updating units for resource ID:", resourceId);
    const units = resourceUnitsMap[resourceId] || [];
    console.log("Units:", units);


    units.forEach((unit: string) => {
      const option = document.createElement('option');
      option.value = unit;
      option.text = unit;
      unitSelect.appendChild(option);
    });
  }
}

// Initialize the function with different events
document.addEventListener('turbo:render', initAdminObservationResourceForm);
document.addEventListener('turbo:frame-load', initAdminObservationResourceForm);

document.addEventListener("turbo:frame-render", (event) => {
  if ((event.target as any).id === "observation_resource") {
    console.log("Turbo-Frame geladen:", event);
    initAdminObservationResourceForm();
  }
});

document.addEventListener('turbo:load', () => {
  console.log('Turbo:load triggered.');
  initAdminObservationResourceForm();
});

document.addEventListener("turbo:before-stream-render", ((event) => {
  const fallbackToDefaultActions = event.detail.render

  StreamActions.log = function () {
    console.log(this.getAttribute("message"))
  }

  event.detail.render = function (streamElement) {

    console.log("turbo stream event");

    console.log(streamElement);

    if (streamElement.action == "alert") {
      // ...
    } else if (streamElement.action == "log") {
      // ...
    } else {
      fallbackToDefaultActions(streamElement)
    }
  }
}))
