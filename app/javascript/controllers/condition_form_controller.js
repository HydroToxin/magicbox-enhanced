import flatpickr from 'flatpickr';
import BaseFormController from "./base_form_controller"

export default class extends BaseFormController {
  static targets = []

  connect() {
    super.connect()
     console.log("ConditionFormController connected")
  }

  disconnect() {
  }

  add(event) {
    event.preventDefault();

    const uniqueId = new Date().getTime() + Math.floor(Math.random() * 1000);
    const content = this.templateTarget.innerHTML.replace(/NEWRECORD/g, uniqueId);
    this.targetTarget.insertAdjacentHTML('beforebegin', content);
  }

  generateId() {

  }
  remove(event) {
    event.preventDefault();
    let item = event.target.closest('.condition-fields');
    if (item.dataset.newRecord === 'true') {
      item.remove();
    } else {
      item.querySelector('input[name*="_destroy"]').value = 1;
      item.style.display = 'none';
    }
  }

  click(event) {
    console.log(event.target.value);
    const turboFrameId = event.currentTarget.dataset.turboFrameId;
    const selectedOption = event.target.value;
    const url = `/admin/conditions/update?turbo_frame_id=${turboFrameId}&selected_option=${selectedOption}`;

    console.log("frame=" + turboFrameId) ;

    fetch(url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
    });
  }
}
