import Chart from 'chart.js';
import chartColors from './chart-colors';
import metersToKilometers from './meters-to-kilometers';

export default function averageSpeedChart(labels = [], average_speeds = []) {
  const ctx = document.getElementById("average_speed").getContext('2d');

  return  new Chart(ctx, {
    type: 'line',
    data: {
      labels: labels,
      datasets: [{
        borderColor: chartColors.purple,
        backgroundColor: chartColors.purple,
        label: "Distance",
        data: average_speeds.map((speed) => (speed * 3.6).toFixed(2)),
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
          label: (tooltipItems, data) => tooltipItems.yLabel + ' km/h',
        },
      },
      hover: {
        mode: 'nearest',
        intersect: true,
      },
      scales: {
        yAxes: [{
          ticks: {
            callback: (value, index, values) => ` ${value} km/h`,
          },
        }],
      }
    }
  });
}
