import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"]

  connect() {
    console.log('NavbarController connected.');
  }

  toggle() {
    console.log('toggle.');
    if (window.innerWidth <= 768) {
      // Mobile behavior
      const sidebar = document.querySelector('.sidebar');
      sidebar.classList.toggle('show');
    } else {
      // Desktop behavior
      document.body.classList.toggle('sidebar-collapsed');
    }
  }
}