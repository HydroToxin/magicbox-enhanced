// app/javascript/controllers/sidebar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('SidebarController connected');
    this.initializePopStateHandler();
  }

  disconnect() {
    window.removeEventListener('popstate', this.handlePopState);
  }

  initializePopStateHandler() {
    window.addEventListener('popstate', this.handlePopState.bind(this));
  }

  handlePopState = () => {
    const newUrl = window.location.pathname;
    this.updateFrameContent(newUrl);
    this.activateLinkByUrl(newUrl);
  }

  updateFrameContent(url) {
    const frame = document.getElementById('main-content');
    if (frame) {
      Turbo.visit(url, { frame: frame });
    }
  }

  activateLink(event) {
    console.log('activateLink');
    const clickedLink = event.currentTarget;
    this.deactivateAllLinks();
    clickedLink.parentElement.classList.add('active');

    const url = clickedLink.getAttribute('href');
    window.history.pushState({}, '', url);
  }

  deactivateAllLinks() {
    console.log('deactivateLink');
    const sidebarLinks = this.element.querySelectorAll(".nav-item a");
    sidebarLinks.forEach(link => {
      link.parentElement.classList.remove('active');
    });
  }

  activateLinkByUrl(url) {
    this.deactivateAllLinks();
    const links = this.element.querySelectorAll(".nav-item a");
    links.forEach(link => {
      if (link.getAttribute('href') === url) {
        link.parentElement.classList.add('active');
      }
    });
  }
}
