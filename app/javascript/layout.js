document.addEventListener('turbo:load', function() {
  const sidebarToggle = document.getElementById('sidebar-toggle');
  const body = document.body;

  if (sidebarToggle) {
    sidebarToggle.addEventListener('click', function() {
      if (window.innerWidth <= 768) {
        // Mobile behavior
        const sidebar = document.querySelector('.sidebar');
        sidebar.classList.toggle('show');
      } else {
        // Desktop behavior
        body.classList.toggle('sidebar-collapsed');
      }
    });
  }
});
