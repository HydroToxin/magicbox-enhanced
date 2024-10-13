import flatpickr from 'flatpickr';
import { German } from 'flatpickr/dist/l10n/de.js'

function initAdminGrowsForm() {

  // Check if the admin grows form container is present in the DOM
  const adminGrowsWeeks = document.getElementById("admin-grows-form");

  const birthTypeSelect: HTMLElement | null = document.getElementById("birth_type_select");
  if (birthTypeSelect === null) return;
  birthTypeSelect.addEventListener("change", toggleMotherSelect);

  const dateInput = document.getElementById('start_date_input') as HTMLInputElement;
  if (dateInput) {
    flatpickr(dateInput, {
      allowInput: true,
      dateFormat: 'd.m.Y',
      locale: German,
    });
  };


  // Initial check
  toggleMotherSelect();

}

function toggleMotherSelect() {
  const birthTypeSelect = document.getElementById("birth_type_select") as HTMLSelectElement;
  const motherSelect = document.getElementById("mother_select") as HTMLSelectElement;

  if (birthTypeSelect === null) return;
  if (motherSelect === null) return;

  if ((birthTypeSelect).value === "from_seed") {
    motherSelect.disabled = true;
    motherSelect.selectedIndex = -1; // Deselect any selection
  } else {
    motherSelect.disabled = false;
  }
}

// Initialize the form with different events
document.addEventListener("DOMContentLoaded", initAdminGrowsForm);
document.addEventListener("turbo:load", initAdminGrowsForm);
document.addEventListener("nested:fieldAdded", initAdminGrowsForm);
