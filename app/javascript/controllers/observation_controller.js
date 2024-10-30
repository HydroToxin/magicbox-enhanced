import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["growSelect", "subjectSelect"]

  connect() {
    console.log('ObservationController connected');
  }

  async changeGrow(event) {
    const growId = this.growSelectTarget.value;
    if (growId) {
      try {
        const response = await fetch(`/api/v1/grows/${growId}`);
        const data = await response.json();
        const subjects = data.subjects;
        console.log("Fetched data:", subjects); // Debug-Ausgabe

        this.updateSubjectSelect(subjects);
      } catch (error) {
        console.error("Error fetching subjects:", error);
      }
    } else {
      this.updateSubjectSelect([]); // Clear subjects if no grow is selected
    }
  }

  updateSubjectSelect(subjects) {
    const subjectSelect = this.subjectSelectTarget;
    subjectSelect.innerHTML = ""; // Clear existing options

    subjects.forEach(subject => {
      const option = document.createElement("option");
      option.value = subject.id;
      option.textContent = subject.name;
      subjectSelect.appendChild(option);
    });
  }
}