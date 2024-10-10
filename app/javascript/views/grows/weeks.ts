import { scheduler } from "dhtmlx-scheduler";

function initScheduler() {
  // Check if the scheduler container is present in the DOM
  const growsWeeks = document.getElementById("grows-weeks");

  if (!growsWeeks) {
    return; // Exit the function if the container is not present
  }

    if (typeof scheduler === "undefined") {
    console.error("Scheduler is not available. Check your import/import order.");
    return;
  }

  const todosJson = growsWeeks.getAttribute("data-grow-todos-json");
  const issuesJson = growsWeeks.getAttribute("data-grow-issues-json");
  const weeksJson = growsWeeks.getAttribute("data-grow-weeks-json");
  const observationsJson =  growsWeeks.getAttribute("data-observations-json");

  // Initialize the scheduler
  scheduler.init("grows-weeks", new Date(), "month");

  // Parse JSON data into the scheduler
  scheduler.parse(todosJson);
  scheduler.parse(issuesJson);
  scheduler.parse(weeksJson);
  scheduler.parse(observationsJson);

  // Attach double-click event listener
  scheduler.attachEvent("onDblClick", function(id, e) {
    console.log(e);
    const event = scheduler.getEvent(id);
    window.location.replace(event.url);
    return false;
  });
}

// Initialize the scheduler with different events
document.addEventListener("DOMContentLoaded", initScheduler);
document.addEventListener("turbo:load", initScheduler);
document.addEventListener("nested:fieldAdded", initScheduler);
