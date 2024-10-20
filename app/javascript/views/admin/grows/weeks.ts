import { scheduler } from "dhtmlx-scheduler";

function initAdminGrowsWeeks() {
  // Check if the scheduler container is present in the DOM
  const adminGrowsWeeks = document.getElementById("admin-grows-weeks");

  if (!adminGrowsWeeks) {
    return; // Exit the function if the scheduler is not present
  }

  if (typeof scheduler === "undefined") {
    console.error("Scheduler is not available. Check your import/import order.");
    return;
  }

  const growWeeksJson = adminGrowsWeeks.getAttribute("data-grow-weeks-json");
  const weeksJson = adminGrowsWeeks.getAttribute("data-weeks-json");
  const observationsJson =  adminGrowsWeeks.getAttribute("data-observations-json");

  if (!growWeeksJson || !weeksJson || !observationsJson) {
    console.error("Missing JSON data for scheduler initialization.");
    return;
  }

  // Initialize the scheduler
  scheduler.init("admin-grows-weeks", new Date(), "month");

  // Parse the weeks and observations JSON data
  scheduler.parse(weeksJson);
  scheduler.parse(observationsJson);

  // Attach event listeners
  scheduler.attachEvent("onClick", function (id, e) {
    console.log("onClick");
    return true;
  });

  scheduler.attachEvent("onDblClick", function (id, e) {
    console.log(e);
    const event = scheduler.getEvent(id);
    window.location.replace(event.url);
    return false;
  });
}

// Initialize the scheduler with different events
document.addEventListener("DOMContentLoaded", initAdminGrowsWeeks);
document.addEventListener("turbo:load", initAdminGrowsWeeks);
document.addEventListener("nested:fieldAdded", initAdminGrowsWeeks);
