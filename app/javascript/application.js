// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Entry point for the build script in your package.json

// Import Turbo
import "@hotwired/turbo-rails"

// Import Stimulus
import { Application } from "@hotwired/stimulus"
import "./controllers/application"

import { createPopper } from '@popperjs/core';

import * as bootstrap from "bootstrap";

import Highcharts from "highcharts"
import moment from 'moment';
import 'moment/locale/en-gb';
import Chartkick from 'chartkick';
import Chart from 'chart.js/auto';
import highchartsMore from 'highcharts/highcharts-more';
import highchartsAccessibility from 'highcharts/modules/accessibility';

highchartsMore(Highcharts);
highchartsAccessibility(Highcharts);

Chartkick.use(Highcharts);
window.createPopper = createPopper;
import './admin';
import './views/calendar/calendar'
import './views/grows/weeks'
const application = Application.start()


function init_views() {
  console.log("init_views");

}
document.addEventListener('turbo:load', () => {
  console.log('Turbo ist geladen über addEventListener');
  init_views();
  if (window.history.state && window.history.state.turbo) {
    window.addEventListener("popstate", function () { location.reload(true); });
  }
});

document.addEventListener('DOMContentLoaded', function () {
  console.log('DOMContentLoaded');
  //alert(window.FontAwesome.config)
  /*moment.locale('de');
  Highcharts.wrap(Highcharts.Tooltip.prototype, 'refresh', function (proceed) {
    this.options.formatter = function () {
      moment.locale('de');
      const date = moment.utc(this.x).format('dddd, D. MMMM, HH:mm [Uhr]');
      const value = this.y;
      return `<b>${this.series.name}</b><br/>Datum: ${date}<br/>Wert: ${value}`;
    };
    proceed.apply(this, Array.prototype.slice.call(arguments, 1));
  });*/
});
