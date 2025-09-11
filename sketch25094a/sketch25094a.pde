enum AnimationState {
  IDLE,          
  BAR_GROWING,   
  BALL_DROPPING, 
  COMPLETED     
}
AnimationState currentState = AnimationState.IDLE;

float barHeight = 0;
float barTargetHeight = 180;
float barGrowthRate = 3;
color barColor;
color[] colorPalette;
int colorIndex = 0;

float ballY = -50;
float ballVelocity = 0;
float gravity = 0.8;
float damping = 0.7; 
float ballTargetY; 
int bounceCount = 0;
float minBounceVelocity = 0.5;
float ballRestingOffset = 20; 

int resetTimer = 0;
int resetDelay = 60; 

float centerX;
float barY;
float barWidth = 60;
float ballRadius = 30;

void setup() {
  size(800, 800);
  smooth();
  centerX = width / 2;
  barY = height * 0.7; 

  colorPalette = new color[] {
    color(50, 50, 200),   
    color(200, 50, 50),   
    color(50, 200, 50)   
  };
  barColor = colorPalette[colorIndex];
}

void draw() {
  background(240);

  switch (currentState) {
    case IDLE:
      fill(100);
      textAlign(CENTER, BOTTOM);
      textSize(20);
      text("Press 'i' to start\nPress 'c' to change color", width / 2, height - 20);
      break;
      
    case BAR_GROWING:
      barHeight += barGrowthRate;
      if (barHeight >= barTargetHeight) {
        barHeight = barTargetHeight;
        startBallDrop(); 
      }
      break;
      
    case BALL_DROPPING:
      ballVelocity += gravity;
      ballY += ballVelocity;
      
      if (ballY >= ballTargetY) {
        ballY = ballTargetY;
        ballVelocity *= -damping; 
        bounceCount++;
        
        if (abs(ballVelocity) < minBounceVelocity || bounceCount > 10) {
          ballVelocity = 0; 
          currentState = AnimationState.COMPLETED;
        }
      }
      break;
      
    case COMPLETED:
      fill(50, 200, 50);
      textAlign(CENTER, CENTER);
      textSize(32);
      text("Complete!", centerX, height * 0.85);
      resetTimer++;
      if (resetTimer >= resetDelay) {
        resetAnimation();
      }
      break;
  }
  
  if (barHeight > 0) {
    fill(barColor);
    noStroke();
    rectMode(CENTER);
    rect(centerX, barY - barHeight/2, barWidth, barHeight, 10);
  }

  if (currentState == AnimationState.BALL_DROPPING || currentState == AnimationState.COMPLETED) {
    fill(bounceCount <= 3 ? barColor : color(255, 100, 100));
    noStroke();
    ellipse(centerX, ballY, ballRadius * 2, ballRadius * 2);
  }
}

void keyPressed() {
  if (Character.toLowerCase(key) == 'i' && currentState == AnimationState.IDLE) {
    currentState = AnimationState.BAR_GROWING;
  }
  if (Character.toLowerCase(key) == 'c') {
    colorIndex = (colorIndex + 1) % colorPalette.length; 
    barColor = colorPalette[colorIndex];
  }
}

void keyReleased() {
  if (Character.toLowerCase(key) == 'i' && currentState == AnimationState.BAR_GROWING) {
    startBallDrop();
  }
}

void startBallDrop() {
  currentState = AnimationState.BALL_DROPPING;
  ballTargetY = barY - barHeight - ballRadius - ballRestingOffset;
  ballY = 50; 
  ballVelocity = 0;
}

void resetAnimation() {
  barHeight = 0;
  
  ballY = -50;
  ballVelocity = 0;
  bounceCount = 0;
  
  resetTimer = 0;
  currentState = AnimationState.IDLE;
}