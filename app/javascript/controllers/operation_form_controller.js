import flatpickr from 'flatpickr';
import NestedForm from "@stimulus-components/rails-nested-form"


export default class extends NestedForm {
  static targets = ["click", "template", "target"]

  connect() {
    console.log('OperationController connected.');
  }

  disconnect() {
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

  remove(event) {
    event.preventDefault();
    let item = event.target.closest('.operation-fields');
    if (item.dataset.newRecord === 'true') {
      item.remove();
    } else {
      item.querySelector('input[name*="_destroy"]').value = 1;
      item.style.display = 'none';
    }
  }

  add(event) {
    super.add(event);
  }
}