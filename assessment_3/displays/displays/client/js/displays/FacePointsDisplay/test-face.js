let points = [];
let triangles = [];
let features;
let pointsToRender = [];
let boxX;
let boxY;
let boxW;
let boxH;
let v1, v2, v3, v4;
let sideLength;

function setup() { 
  features = [
    [
      [172.973, 216.573],
      [180.438, 212.994],
      [189.012, 213.277],
      [196.711, 216.161],
    ],
    [
      [247.247, 217.378],
      [255.447, 214.366],
      [264.464, 215.362],
      [272.456, 219.341],
    ],
    [
      [160.456, 190.877],
      [169.024, 183.201],
      [179.743, 180.384],
      [190.659, 180.993],
      [200.803, 184.091],
    ],
    [
      [239.469, 184.125],
      [254.244, 181.191],
      [269.342, 181.642],
      [283.515, 187.349],
      [294.273, 198.521],
    ],
    [
      [172.973, 216.573],
      [180.438, 212.994],
      [189.012, 213.277],
      [196.711, 216.161],
      [188.864, 218.61],
      [180.586, 218.921],
    ],
    [
      [247.247, 217.378],
      [255.447, 214.366],
      [264.464, 215.362],
      [272.456, 219.341],
      [264.092, 221.01],
      [255.299, 220.306],
    ],
    //[
    //  [148.722, 226.08], 
    //  [145.94, 247.269], 
    //  [144.959, 268.674], 
    //  [145.226, 289.062], 
    //  [148.168, 308.349], 
    //  [156.501, 325.313], 
    //  [171.138, 338.341], 
    //  [189.429, 347.332], 
    //  [209.997, 350.262], 
    //], 
    //[
    //  [209.997, 350.262], 
    //  [235.006, 351.803], 
    //  [259.716, 348.29], 
    //  [282.818, 340.176], 
    //  [300.841, 325.679], 
    //  [310.976, 305.173], 
    //  [316.669, 281.271], 
    //  [319.88, 255.894], 
    //  [322.124, 230.515], 
    //], 
    [
      [148.722, 226.08],
      [145.94, 247.269],
      [144.959, 268.674],
      [145.226, 289.062],
      [148.168, 308.349],
      [156.501, 325.313],
      [171.138, 338.341],
      [189.429, 347.332],
      [209.997, 350.262],
      [235.006, 351.803],
      [259.716, 348.29],
      [282.818, 340.176],
      [300.841, 325.679],
      [310.976, 305.173],
      [316.669, 281.271],
      [319.88, 255.894],
      [322.124, 230.515],
    ],
    [
      [185.785, 294.669],
      [193.352, 286.588],
      [202.278, 280.625],
      [212.08, 281.312],
      [224.065, 281.449],
      [234.939, 288.39],
      [245.342, 296.589],
      [234.619, 300.676],
      [222.964, 302.043],
      [211.362, 301.549],
      [201.865, 301.498],
      [192.905, 299.556],
    ],
    [
      [185.785, 294.669],
      [201.857, 290.901],
      [211.8, 290.136],
      [224.331, 291.473],
      [245.342, 296.589],
      [224.181, 292.023],
      [211.744, 290.61],
      [201.855, 291.354],
    ],
    [
      [216.372, 208.94],
      [214.538, 219.339],
      [212.642, 229.554],
      [210.739, 239.685],
    ],
    [
      [200.68, 258.08],
      [206.032, 259.167],
      [211.576, 259.429],
      [219.248, 259.587],
      [226.865, 258.964],
    ],
    [
      [160.456, 190.877],
      [169.024, 183.201],
      [179.743, 180.384],
      [190.659, 180.993],
      [200.803, 184.091],
      [239.469, 184.125],
      [254.244, 181.191],
      [269.342, 181.642],
      [283.515, 187.349],
      [294.273, 198.521],
      [322.124, 230.515],
      [319.88, 255.894],
      [316.669, 281.271],
      [310.976, 305.173],
      [300.841, 325.679],
      [282.818, 340.176],
      [259.716, 348.29],
      [235.006, 351.803],
      [209.997, 350.262],
      [189.429, 347.332],
      [171.138, 338.341],
      [156.501, 325.313],
      [148.168, 308.349],
      [145.226, 289.062],
      [144.959, 268.674],
      [145.94, 247.269],
      [148.722, 226.08],
    ],
  ];
  createCanvas(1024, 768);
  //make new function that takes 2d array and make it 1d, then run in setup
  //set points = result of this function
  features = mapVectorsToRect(features, 120, 190, 350, 350);

  points = convertTo1D(features);
  boxX = 50;
  boxY = 120;
  boxW = 480;
  boxH = 480;
  v1 = createVector(boxX, boxY);
  v2 = createVector(boxX + boxW, boxY);
  v3 = createVector(boxX + boxW, boxY + boxH);
  v4 = createVector(boxX, boxY + boxH);
  sideLength = (1.0 - (1.0 * 0.7))/2.0;
  
  
} 

// New array `pointsToRender`
// Add point from `points` each frame
// re-calculater `triangles` variable from these `pointsToRender` (  triangles = Delaunay.triangulate(points);)
// noramlise 

let vertexCounter = 0;

function draw() { 
  background(0);
  
   // Box visual
  stroke(255);
  // Top
  line(v1.x, v1.y, v1.x + width * sideLength, v1.y);
  line(v2.x, v2.y, v2.x - width * sideLength, v2.y);
  // Right
  line(v2.x, v2.y, v2.x, v2.y + height * sideLength);
  line(v3.x, v3.y, v3.x, v3.y - height * sideLength);
  // Bottom
  line(v3.x, v3.y, v3.x - width * sideLength, v3.y );
  line(v4.x, v4.y, v4.x + width * sideLength, v4.y );
  // Left
  line(v1.x, v1.y, v1.x, v1.y + height * sideLength);
  line(v4.x, v4.y, v4.x, v4.y - height * sideLength);

  
  stroke(0);
  
  vertexCounter++;
  
  if (vertexCounter < points.length) {
    pointsToRender.push(points[vertexCounter]); 
  }

  triangles = Delaunay.triangulate(pointsToRender);
  
  
  for (let i = 0; i < triangles.length; i += 3) {
    beginShape();
    fill(255-(i / triangles.length)*255, 0, 128);
    vertex(pointsToRender[triangles[i]][0], pointsToRender[triangles[i]][1]);
    vertex(pointsToRender[triangles[i+1]][0], pointsToRender[triangles[i+1]][1]);
	  vertex(pointsToRender[triangles[i+2]][0],           pointsToRender[triangles[i+2]][1]);
    endShape(CLOSE);
  }
    fill(255);
  for (let i = 0; i < points.length; i++) {
    ellipse(points[i][0], points[i][1], 7, 7);
  }
}

// function mousePressed() {
//   points.push([mouseX, mouseY]);
//   triangles = Delaunay.triangulate(points);
// }

function convertTo1D(arrayToConvert) {
  let new1DArray = [];
  for (var i = 0; i < arrayToConvert.length; i++) {
      new1DArray = new1DArray.concat(arrayToConvert[i]);
  }
  
  return new1DArray;
}

function mapVectorsToRect(vects, x, y, width, height) {
  var minY = width,
    maxY = 0,
    minX = height,
    maxX = 0;
  
  // console.log(vects);
  
  for (let i = 0; i < vects.length; i++) {
    for (let j = 0; j < vects[i].length; j++) {
      var currentVal = vects[i][j];
      minY = constrain(currentVal[1], 0.0, minY);
      maxY = constrain(currentVal[1], maxY, height);
      minX = constrain(currentVal[0], 0.0, minX);
      maxX = constrain(currentVal[0], maxX, width);
    }
  }

  // map face
  for (var i = 0; i < vects.length; i++) {
    for (var j = 0; j < vects[i].length; j++) {
      let currentVal = vects[i][j];
      newX = map(currentVal[0], minX, maxX, x, x + width);
      newY = map(currentVal[1], minY, maxY, y, y + height);
      
      vects[i][j] = [newX, newY];
    }
  }
  // console.log(minX);
  return vects;
}