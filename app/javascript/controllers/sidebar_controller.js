// app/javascript/controllers/sidebar_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  }

  disconnect() {
  }

  reconnect() {
    console.log('reconnect');
  }

  activateLink(event) {
    console.log('activateLink');
    const clickedLink = event.currentTarget; // currentTarget verweist auf das Element, das das Event ausgelöst hat.

    // Entferne die "active" Klasse von anderen Links
    this.deactivateAllLinks();

    // Setze die "active" Klasse auf den angeklickten Link
    clickedLink.parentElement.classList.add('active');

    const url = clickedLink.getAttribute('href');
    window.history.pushState({}, '', url);
  }

  deactivateAllLinks() {
    console.log('deactivateLink');
    // Entferne "active" von allen Link-Listenelementen
    const sidebarLinks = this.element.querySelectorAll("#sidebar .sidebar-body a");
    sidebarLinks.forEach(link => {
      link.parentElement.classList.remove('active');
    });
  }
}