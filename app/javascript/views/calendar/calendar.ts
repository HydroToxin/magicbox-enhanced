import { scheduler } from "dhtmlx-scheduler";

function initCalendar() {
  const calendarContainer = document.getElementById("calendar-calendar");

  if (!calendarContainer) {
    return;
  }

  const calendarDefaultView = calendarContainer.getAttribute("data-calendar-default-view");
  const calendarTodosEnabled = calendarContainer.getAttribute("data-calendar-todos-enbaled");
  const calendarWeeksEnabled = calendarContainer.getAttribute("data-calendar-weeks-enabled");
  const calendarIssuesEnabled = calendarContainer.getAttribute("data-calendar-issues-enabled");
  const calendarObservationsEnabled = calendarContainer.getAttribute("data-calendar-observations-enabled");

  const todosJson = calendarContainer.getAttribute("data-clalendar-todos");;
  const weeksJson = calendarContainer.getAttribute("data-calendar-weeks");
  const issuesJson = calendarContainer.getAttribute("data-calendar-issues");
  const observationsJson = calendarContainer.getAttribute("data-calendar-observations");

  if(calendarDefaultView) {
    scheduler.init("calendar-calendar", new Date(), calendarDefaultView);

    if (calendarTodosEnabled) {
      scheduler.parse(todosJson);
    }

    if (calendarWeeksEnabled) {
      scheduler.parse(weeksJson);
    }

    if (calendarIssuesEnabled) {
      scheduler.parse(issuesJson);
    }

    if (calendarObservationsEnabled) {
      scheduler.parse(observationsJson);
    }
  }
}

document.addEventListener("DOMContentLoaded", initCalendar);
document.addEventListener("turbo:load", initCalendar);
document.addEventListener("nested:fieldAdded", initCalendar);