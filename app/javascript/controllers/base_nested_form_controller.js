import flatpickr from 'flatpickr';
import NestedForm from "@stimulus-components/rails-nested-form"

export default class extends NestedForm  {

  connect() {
    super.connect()
    console.log('BaseFormController connected.');

    if (typeof window.initBootrstrapToggle === "function") {
      window.initBootrstrapToggle();
    };

    this.initializeTimeFlatpickr();
    this.startMutationObserver();
  }

  disconnect() {
    this.mutationObserver.disconnect();
  }
  initializeTimeFlatpickr() {
    console.log('initializeFlatpickr');
    const dateInputs = document.querySelectorAll('.select-time');
    dateInputs.forEach(dateInput => {
      console.log(dateInput);

      if (dateInput) {
        flatpickr(dateInput, {
          enableTime: true,
          noCalendar: true,
          dateFormat: "H:i",
          time_24hr: true
        });
      };
    });
  }

  startMutationObserver() {
    this.mutationObserver = new MutationObserver((mutationsList) => {
      mutationsList.forEach(mutation => {
        if (mutation.type === 'childList') {
          mutation.addedNodes.forEach(node => {
            if (node.nodeType === Node.ELEMENT_NODE) {
              const focusElement = node.querySelector('[id*="condition_type"]');

              if (focusElement) {
                console.log('Element with ID condition_type detected.');
                //focusElement.focus();
              }

              if (node.classList.contains('select-time') || node.querySelector('.select-time')) {
                if (!this.initializeFlatpickr === undefined) {
                  this.initializeFlatpickr();
                }
              }
            }
          });
        }
      });
    });

    this.mutationObserver.observe(document.body, { childList: true, subtree: true });
  }
}