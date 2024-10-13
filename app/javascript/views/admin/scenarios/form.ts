import flatpickr from 'flatpickr';
import { German } from 'flatpickr/dist/l10n/de.js'

function initAdminScenariosConditionfields() {
  // Check if the conditions container is present in the DOM
  const container = document.getElementById("admin-scenario-condition-fields");

  if (!container) {
    return; // Exit the function if the container is not present
  }

  const dateInput = document.getElementById('scenarios-form-start-time-input') as HTMLInputElement;
  if (dateInput) {
    flatpickr(dateInput, {
      allowInput: false,
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
    });
  };

  toggleConditionTypes(container);

  // Trigger change event to initialize form states
  const conditionTypeElements = container.querySelectorAll<HTMLSelectElement>(".condition_type");
  conditionTypeElements.forEach(selectElement => {
    const event = new Event("change");
    selectElement.dispatchEvent(event);
  });
}

function toggleConditionTypes(container: HTMLElement) {
  const conditionTypeElements = container.querySelectorAll<HTMLSelectElement>(".condition_type");

  conditionTypeElements.forEach(selectElement => {
    selectElement.addEventListener("change", function() {
      console.log("toggleConditionTypes");

      // Hide all condition forms
      const parentElement = selectElement.closest(".d-inline-flex");
      if (!parentElement) return;

      parentElement.querySelectorAll<HTMLElement>(".condition_form").forEach(form => {
        form.style.display = "none";
      });

      // Show the selected condition form
      const selectedForm = parentElement.querySelector<HTMLElement>(".condition_type_" + selectElement.value);
      if (selectedForm) {
        console.log(selectedForm);
        selectedForm.style.display = "block";
      }
    });
  });
}

// Initialize the function with different events
document.addEventListener("DOMContentLoaded", initAdminScenariosConditionfields);
document.addEventListener("turbo:load", initAdminScenariosConditionfields);
document.addEventListener("nested:fieldAdded", initAdminScenariosConditionfields);
