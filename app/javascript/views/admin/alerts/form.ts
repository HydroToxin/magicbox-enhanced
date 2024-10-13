function initAdminAlertForm() {
  const adminAlertForm = document.getElementById("admin-alerts-form") as HTMLFormElement | null;

  if (!adminAlertForm) {
    return; // Exit the function if the form is not present
  }

  toggleAlertTypes();
  document.querySelectorAll<HTMLSelectElement>(".alert_types").forEach(element => {
    console.log(`Dispatching change event for element with value: ${element.value}`);
    element.dispatchEvent(new Event('change'));
  });
}

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

document.addEventListener("DOMContentLoaded", function() {
  initAdminAlertForm();
});

document.addEventListener("turbo:load", function() {
  initAdminAlertForm();
});

document.addEventListener("DOMContentLoaded", function() {
  initAdminAlertForm();
});
