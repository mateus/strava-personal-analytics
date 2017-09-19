import Chart from 'chart.js';
import chartColors from './chart-colors';
import metersToKilometers from './meters-to-kilometers';

export default function totalTimeVSMovingTimeChart(labels = [], restingTime = [], movingTime = [], totalTime = []) {
  const ctx = document.getElementById("total_time_vs_moving_time").getContext('2d');

  return new Chart(ctx, {
    type: 'bar',
    data: {
      labels: labels,
      datasets: [{
        borderColor: chartColors.yellow,
        backgroundColor: chartColors.yellow,
        label: "Resting time",
        data: restingTime,
      }, {
        borderColor: chartColors.green,
        backgroundColor: chartColors.green,
        label: "Moving time",
        data: movingTime,
      }, {
        type: 'line',
        fill: true,
        pointRadius: 0,
        borderColor: chartColors.blue,
        backgroundColor: chartColors.blue,
        label: "Total time",
        data: totalTime,
      }],
    },
    options: {
      responsive: true,
      legend: {
        display: true,
      },
      tooltips: {
        mode: 'index',
        intersect: false,
        callbacks: {
          label: (tooltipItems, data) => ` ${secondsToString(tooltipItems.yLabel)}`,
        },
      },
      hover: {
        mode: 'nearest',
        intersect: true,
      },
      scales: {
        xAxes: [{
          stacked: true,
        }],
        yAxes: [{
          stacked: true,
          ticks: {
            callback: (value, index, values) => secondsToHours(value),
          },
        }],
      },
    }
  });
}

function secondsToHours(sec_num) {
  let hours = Math.floor(sec_num / 3600);
  let minutes = Math.floor((sec_num - (hours * 3600)) / 60);

  if (hours < 10) { hours = "0" + hours; }
  if (minutes < 10) { minutes = "0" + minutes; }

  return `${hours}:${minutes}`;
}

function secondsToString(seconds) {
  const numhours = Math.floor(((seconds % 31536000) % 86400) / 3600);
  const numminutes = Math.floor((((seconds % 31536000) % 86400) % 3600) / 60);
  const numseconds = (((seconds % 31536000) % 86400) % 3600) % 60;
  if (numhours > 0) { return `${numhours} hours ${numminutes} minutes ${numseconds} seconds`; }
  return `${numminutes} minutes ${numseconds} seconds`;
}
