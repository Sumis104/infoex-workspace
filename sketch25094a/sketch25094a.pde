float sliderY;

void setup() {
  size(800, 800);
  sliderY = height / 2;
  rectMode(CENTER); 
}


void draw() {
  background(255);

  sliderY = lerp(sliderY, mouseY, 0.1);


  fill(0);
  float toothSize = 20;
  for (float y = 0; y < height; y += toothSize) {
    if (y > sliderY) {
      if ((y / toothSize) % 2 == 0) {
        rect(width/2 + toothSize/2, y, toothSize, toothSize); // 右
      } else {
        rect(width/2 - toothSize/2, y, toothSize, toothSize); // 左
      }
    }
   }
  fill(0); 
  stroke(0);
  strokeWeight(3);
  ellipse(width/2, sliderY, 60, 60);
  fill(255);
  ellipse(width/2, sliderY, 40, 40);
}