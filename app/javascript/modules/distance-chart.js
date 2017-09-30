import Chart from 'chart.js';
import chartColors from './chart-colors';
import metersToKilometers from './meters-to-kilometers';

export default function distanceChart(labels = [], distances = []) {
  const ctx = document.getElementById("distance").getContext('2d');

  return new Chart(ctx, {
    type: 'line',
    data: {
      labels: labels,
      datasets: [{
        borderColor: chartColors.blue,
        backgroundColor: chartColors.blue,
        lineTension: 0,
        label: 'Distance',
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
            stepSize: 10,
            callback: (value, index, values) => value + ' km',
          },
        }],
      },
    }
  });
}
