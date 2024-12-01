import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["file", "preview", "add", "delete"]

  connect() {
    console.log("Image Upload Controller connected");
    this.fileTarget.addEventListener('change', this.preview.bind(this));
  }

  add() {
    console.log("add clicked");
    this.fileTarget.click();
  }

  preview() {
    console.log("preview called")
    const file = this.fileTarget.files[0];
    if (file) {
      this.addTarget.style.display = 'none';
      this.previewTarget.style.display = 'block';
      this.deleteTarget.style.display = 'block';

      const reader = new FileReader();
      reader.onload = event => {
        this.previewTarget.src = event.target.result;
      }
      reader.readAsDataURL(file);
    }
  }

  deleteImage() {
    this.previewTarget.src = '';
    this.fileTarget.value = '';
    this.addTarget.style.display = 'block';
    this.previewTarget.style.display = 'none';
    this.deleteTarget.style.display = 'none';
  }
}
