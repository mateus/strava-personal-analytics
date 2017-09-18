import Chart from 'chart.js';
import chartColors from './chart-colors';
import metersToKilometers from './meters-to-kilometers';

export default function distanceChart(labels = [], distances = []) {
  const ctx = document.getElementById("distance").getContext('2d');

  window.distanceChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: labels,
      datasets: [{
        borderColor: chartColors.red,
        backgroundColor: chartColors.red,
        label: "Distance",
        data: metersToKilometers(distances),
        fill: false,
      }],
    },
    options: {
      responsive: true,
      legend: {
        display: false,
      },
      tooltips: {
        mode: 'index',
        intersect: false,
        callbacks: {
          label: (tooltipItems, data) => ` ${tooltipItems.yLabel} km`,
        },
      },
      hover: {
        mode: 'nearest',
        intersect: true,
      },
      scales: {
        yAxes: [{
          ticks: {
            callback: (value, index, values) => value + ' km',
          },
        }],
      },
    }
  });
}
