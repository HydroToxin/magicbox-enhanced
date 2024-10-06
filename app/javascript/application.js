// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Entry point for the build script in your package.json
// Import UJS
import { Application } from "@hotwired/stimulus"

// Initialisiere das Stimulus-Anwendungsobjekt ohne zusätzliche Controller

import $ from "jquery"; // einziger jQuery Import
window.$ = window.jQuery = $;

import Rails from '@rails/ujs';
//if (!Rails.started) Rails.start();
import Popper from 'popper.js';
import 'bootstrap';
import moment from 'moment';
import 'moment/locale/en-gb';
import 'tempusdominus-bootstrap-4';

import Chart from 'chart.js/auto';
import Highcharts from 'highcharts';
import highchartsMore from 'highcharts/highcharts-more';
highchartsMore(Highcharts);

import chartkick from 'chartkick';
import '@kanety/jquery-nested-form';
import 'bootstrap-select';

window.Popper = Popper;
chartkick.use(Highcharts);

const application = Application.start()

function init_views() {
  console.log("init_views");

  $("#sidebar").mCustomScrollbar({
    theme: "minimal"
  });

  $('#sidebarCollapse').on('click', function () {
    $('#sidebar, #content').toggleClass('active');
    $('.collapse.in').toggleClass('in');
    $('a[aria-expanded=true]').attr('aria-expanded', 'false');
  });

  $('#roomsSubmenu').collapse('show');

  $('.timepicker').datetimepicker({ format: 'HH:mm', stepping: "5", useCurrent: false });
  $('.weekpicker').datetimepicker({ format: 'YYYY-MM-DD', inline: true, sideBySide: true });
  $('#datetimepicker-todo-date').datetimepicker({ format: 'YYYY-MM-DD HH:mm', inline: true, sideBySide: true });

  $('input[type=checkbox][data-toggle^=toggle]').bootstrapToggle();

  $(function () {
    $('[data-toggle="popover"]').popover({ container: 'body' })

    $("[data-toggle='popover']").on('shown.bs.popover', function () {
      $('#todo_notify').bootstrapToggle()
    });
  })
}

$(document).ready(function () {
  //init_views();
});

$(document).on('turbo:load', function () {
  console.log('Turbo ist geladen über jquery');
  $(window).trigger('load.bs.select.data-api');
  init_views();
});

$(document).on('nested:fieldAdded', function (event) {
  init_views();
})

document.addEventListener('turbo:load', () => {
  console.log('Turbo ist geladen über addEventListener');
  // Weitere Logik hier
});

document.addEventListener('DOMContentLoaded', function () {
  moment.locale('de');
  Highcharts.wrap(Highcharts.Tooltip.prototype, 'refresh', function (proceed) {
    this.options.formatter = function () {
      moment.locale('de');
      const date = moment.utc(this.x).format('dddd, D. MMMM, HH:mm [Uhr]');
      const value = this.y;
      return `<b>${this.series.name}</b><br/>Datum: ${date}<br/>Wert: ${value}`;
    };
    proceed.apply(this, Array.prototype.slice.call(arguments, 1));
  });
});
