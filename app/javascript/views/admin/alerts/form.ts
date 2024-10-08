function toggleAlertTypes() {
  const alertTypeElements = document.querySelectorAll<HTMLSelectElement>(".alert_types");
  alertTypeElements.forEach((element) => {
    element.addEventListener("change", () => {
      document
        .querySelectorAll<HTMLElement>(".alert_type_from_group")
        .forEach(group => group.style.display = 'none');

      const selectedDiv = document.getElementById(element.value);
      if (selectedDiv) {
        selectedDiv.style.display = 'block';
      }
    });
  });
}

function init() {
  console.log("Initializing alert types");
    toggleAlertTypes();
    document.querySelectorAll<HTMLSelectElement>(".alert_types").forEach(element => {
      console.log(`Dispatching change event for element with value: ${element.value}`);
      element.dispatchEvent(new Event('change'));
    });
}

document.addEventListener("DOMContentLoaded", function() {
  console.log("DOM fully loaded and parsed");
  init();  // Call your original init function

});

document.addEventListener("turbo:load", function() {
  console.log("DOM fully loaded and parsed");
  init();  // Call your original init function

});

document.addEventListener("DOMContentLoaded", function() {
  console.log("nested:fieldAdded fully loaded and parsed");
  init();  // Call your original init function

});
