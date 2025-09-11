float barHeight = 0;
float barTargetHeight = 180;
float barGrowthRate = 3;
boolean isBarGrowing = false;
boolean barComplete = false;

float ballY = -50;
float ballVelocity = 0;
float gravity = 0.8;
float damping = 0.7; 
float ballTargetY; 
boolean ballDropping = false;
boolean ballSettled = false;
int bounceCount = 0;
float minBounceVelocity = 0.5;

// リセット管理
boolean animationComplete = false;
int resetTimer = 0;
int resetDelay = 60; 

// 描画位置
float centerX;
float barY;
float barWidth = 60;
float ballRadius = 30;

void setup() {
  size(800, 800);
  smooth();
  centerX = width / 2;
  barY = height * 0.7; 
  ballTargetY = barY - barTargetHeight - ballRadius - 20; 
}

void draw() {
  background(240);
  
  if (barHeight > 0) {
    fill(50, 50, 200);
    noStroke();
    rectMode(CENTER);
    rect(centerX, barY - barHeight/2, barWidth, barHeight, 10);
  }

  if (isBarGrowing && !barComplete) {
    barHeight += barGrowthRate;
    if (barHeight >= barTargetHeight) {
      barHeight = barTargetHeight;
      barComplete = true;
      isBarGrowing = false;
      ballDropping = true;
      ballY = 50; 
      ballVelocity = 0;
    }
  }
  if (ballDropping && !ballSettled) {
    ballVelocity += gravity;
    ballY += ballVelocity;
    
  if (ballY + ballRadius >= ballTargetY + ballRadius) {
      ballY = ballTargetY;
      ballVelocity *= -damping;
      bounceCount++;
      
  if (abs(ballVelocity) < minBounceVelocity || bounceCount > 10) {
        ballSettled = true;
        ballY = ballTargetY;
        ballVelocity = 0;
        animationComplete = true;
      }
    }
  }
  
  if (ballDropping || ballSettled) {
    if (bounceCount == 0) {
      fill(50, 50, 200);
    } else {
      fill(255, 100, 100);
    }
    noStroke();
    ellipse(centerX, ballY, ballRadius * 2, ballRadius * 2);
  }
  
  if (animationComplete) {
    fill(50, 200, 50);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Complete!", centerX, height * 0.85);
    resetTimer++;
    if (resetTimer >= resetDelay) {
      resetAnimation();
    }
  }
  
  if (!isBarGrowing && !barComplete && !animationComplete) {
    fill(100);
    textAlign(CENTER, BOTTOM);
    textSize(24);
    text("Press i", width / 2, height - 20);
  }
  
}

void keyPressed() {
  if ((key == 'i' || key == 'I') && !isBarGrowing && !barComplete) {
    isBarGrowing = true;
  }
}

void keyReleased() {
  if ((key == 'i' || key == 'I') && isBarGrowing && !barComplete) {
    isBarGrowing = false;
  }
}

void resetAnimation() {
  barHeight = 0;
  isBarGrowing = false;
  barComplete = false;
  
  ballY = -50;
  ballVelocity = 0;
  ballDropping = false;
  ballSettled = false;
  bounceCount = 0;
  
  animationComplete = false;
  resetTimer = 0;
}