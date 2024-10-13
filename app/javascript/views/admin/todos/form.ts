import flatpickr from 'flatpickr';
import { German } from 'flatpickr/dist/l10n/de.js'

function initTodosForm() {

  // Check if the todos form container is present in the DOM
  const todosForm = document.getElementById("todos-form");

  if (!todosForm) return;

  const dateInput = document.getElementById('todos-form-date-input') as HTMLInputElement;
  if (dateInput) {
    flatpickr(dateInput, {
      allowInput: true,
      dateFormat: 'd.m.Y',
      locale: German,
    });
  };
}

// Initialize the form with different events
document.addEventListener("DOMContentLoaded", initTodosForm);
document.addEventListener("turbo:load", initTodosForm);
document.addEventListener("nested:fieldAdded", initTodosForm);
