// スライダーのY座標を滑らかに動かすための変数
float sliderY;

void setup() {
  size(800, 800);
  sliderY = height / 2; // スライダーの初期位置
  rectMode(CENTER); // 四角形を中央基準で描画
}


void draw() {
  // 1. 背景（ジッパーが開いた時に見える部分）
  background(255);

  // 2. スライダーの位置を更新 & 開き具合を計算
  sliderY = lerp(sliderY, mouseY, 0.1); // マウスに滑らかに追従


  // 4. ジッパーの歯を描画
  fill(0); // 歯の色
  float toothSize = 20;
  for (float y = 0; y < height; y += toothSize) {
    // スライダーより下(y > sliderY)が閉じた部分になるように条件を逆にします
    if (y > sliderY) {
      // --- 閉じた部分 ---
      // 元のコードのアイデアを活かし、左右交互に歯を配置
      if ((y / toothSize) % 2 == 0) {
        rect(width/2 + toothSize/2, y, toothSize, toothSize); // 右
      } else {
        rect(width/2 - toothSize/2, y, toothSize, toothSize); // 左
      }
    }
   }
  fill(220, 180, 20); // スライダーの色
  stroke(0);
  strokeWeight(3);
  ellipse(width/2, sliderY, 60, 60);
  fill(255);
  ellipse(width/2, sliderY, 40, 40);
}