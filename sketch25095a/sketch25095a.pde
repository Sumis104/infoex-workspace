boolean isPaused = false;  
float t = 0;               

void setup() {
  size(800, 800);
  noStroke();
}

void draw() {
  background(255);
  int step = 40; 

  // 左下の基準点
  float baseX = 0;
  float baseY = height;

  if (!isPaused) {
    t += 0.02;
  }

  for (int x = 0; x < width; x += step) {
    for (int y = 0; y < height; y += step) {

      // 左下からの距離
      float d = dist(x, y, baseX, baseY);

      // 元の円サイズ（frameCount を使わず t を利用）
      float r = 20 + 10 * sin(t * 3 - d * 0.15);

      // 色はパターン性を持たせる
      fill((x + y) % 255, 150, 200);

      pushMatrix();
      translate(x + step/2, y + step/2);

      beginShape();
      for (float angle = 0; angle < TWO_PI; angle += 0.08) {
        float u = (x + cos(angle) * 30) / (float)width;
        float v = (y + sin(angle) * 30) / (float)height;

        float nr = r + (noise(u * 2, v * 2, t) - 0.5) * 60;

        float px = cos(angle) * nr;
        float py = sin(angle) * nr;
        vertex(px, py);
      }
      endShape(CLOSE);

      popMatrix();
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    isPaused = !isPaused;
  }
}