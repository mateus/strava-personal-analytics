export default function metersToKilometers(arr) {
  return arr.map((el) => (el / 1000).toFixed(2));
}
