<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Turtle Heart Style</title>
<style>
  body {
    margin: 0;
    height: 100vh;
    background: radial-gradient(circle at center, #020202 0%, #000 100%);
    overflow: hidden;
  }
  canvas {
    display: block;
    margin: auto;
  }
</style>
</head>
<body>
<canvas id="heart"></canvas>

<script>
const canvas = document.getElementById("heart");
const ctx = canvas.getContext("2d");
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

function resize() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
}
window.addEventListener("resize", resize);

function hearta(k) {
  return 15 * Math.sin(k) ** 3;
}
function heartb(k) {
  return 12 * Math.cos(k) - 5 * Math.cos(2 * k) - 2 * Math.cos(3 * k) - Math.cos(4 * k);
}

let t = 0;
function draw() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  const cx = canvas.width / 2;
  const cy = canvas.height / 2;
  ctx.beginPath();

  for (let i = 0; i < 6000; i += 0.05) {
    const x = hearta(i / 100) * 20;
    const y = heartb(i / 100) * 20;
    const px = cx + x;
    const py = cy - y;
    if (i === 0) ctx.moveTo(px, py);
    else ctx.lineTo(px, py);
  }

  ctx.shadowBlur = 20;
  ctx.shadowColor = "red";
  ctx.strokeStyle = "red";
  ctx.lineWidth = 2;
  ctx.stroke();

  t += 0.02;
  requestAnimationFrame(draw);
}

draw();
</script>
</body>
</html>
