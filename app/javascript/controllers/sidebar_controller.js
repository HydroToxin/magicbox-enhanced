import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Aktiviere den Link basierend auf der aktuellen URL beim Laden
    this.activateLinkByCurrentUrl();
  }

  activateLinkByCurrentUrl() {
    const currentPath = window.location.pathname;
    const links = this.element.querySelectorAll(".sidebar-content a");
    links.forEach(link => {
      if (link.getAttribute('href') === currentPath) {
        link.parentElement.classList.add('active');
      }
    });
  }

  activateLink(event) {
    const clickedLink = event.currentTarget;
    this.deactivateAllLinks();
    clickedLink.parentElement.classList.add('active');
  }

  deactivateAllLinks() {
    const sidebarLinks = this.element.querySelectorAll(".sidebar-content a");
    sidebarLinks.forEach(link => {
      link.parentElement.classList.remove('active');
    });
  }
}