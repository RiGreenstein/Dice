import java.util.ArrayList;

PFont BoldFont;

int windowSize = 530;

ArrayList<Integer> rolls = new ArrayList<Integer>();

int getLength(ArrayList<Integer> list) {
  int listLength = 0;

  for (Integer num : list) {
    listLength++;
  }

  return listLength;
}

void setup()
{
  size(530, 730);
  noLoop();
  
  BoldFont = createFont("BoldFont.ttf", 10);
  textFont(BoldFont);
}

void drawGraph(ArrayList<Integer> points) {
  ArrayList<Integer> frequencies = new ArrayList<Integer>();
  
  for (int i = 0; i < 6; i++) {
    frequencies.add(0);
  }
  
  for (int i = 0; i < getLength(points); i++) {
    int currentValue = frequencies.get(points.get(i)-1);
    
    frequencies.set(points.get(i)-1, currentValue + 1);
  }
  
  // Draw lines
  fill(150);
  stroke(150);
  strokeWeight(6);
  
  int xMin = 40;
  int xMax = windowSize - 15;
  
  int yMin = windowSize + 160;
  int yMax = windowSize + 15;
  
  int barWidth = (xMax-xMin)/6;
  int heightInterval = (yMin-yMax)/4;
  
  // Baseline
  line(xMin + 3, yMin, xMax, yMin);
  
  // Vertical Lines
  line(xMin, yMin, xMin, yMax+2);
  
  // X-axis text
  
  /*
  textSize(30);
  text("Dice Roll (x)", 5, yMin + 34);
  */
  
  // Horizontal Indicator Bars/Text
  textSize(15);
  textAlign(CENTER);
  for (int i = 0; i <= 6; i++) {
    line(xMin + i*barWidth, yMin+1, xMin + i*barWidth, yMin + 10);
    text(i, xMin + i*barWidth, yMin+30);
  }
  
  /* Zero Text
  textSize(10);
  text("0", 30, yMin+12);
  */
  
  // Vertical Indicator Bars/Text
  textSize(10);
  textAlign(RIGHT);
  for (int i = 0; i <= 4; i++) {
    line(xMin-10, yMin - i*heightInterval, xMin-1, yMin - i*heightInterval);
    text(String.valueOf(i*heightInterval/4) + "%", xMin-15, yMin-i*heightInterval+4);
  }
  
  // Draw Bars
  float graphScale = 100;
  float maxRoll = 0;
  
  for (int i = 0; i <= 5; i++) {
    if (frequencies.get(i) > maxRoll) {
      maxRoll = frequencies.get(i);
    }
  }
  
  graphScale = maxRoll / (float)(getLength(points));
  graphScale += 0.1;
  
  noStroke();
  fill(110);
  
  for (int i = 0; i <= 5; i++) {
    // could error here try int not double
    float newAmt = frequencies.get(i);
    float newFreq = newAmt/ (float)(getLength(points)); // Percentage
    float newHeight = newFreq*(yMin-yMax)/graphScale;
    float newWidth = (xMax-xMin)/6;
    
    float topX = (xMin + i*newWidth)+3;
    float topY = (yMin-newHeight);
    float bottomX = (newWidth)+3;
    float bottomY = (newHeight);
    
    rect(topX, topY, bottomX, bottomY, 3);
  }
}


void draw(){
  //your code here
  background(0, 0, 0);
  
  rolls.clear();
  
  for (int y = 5; y <= 500; y+= 105) {
    for (int x = 5; x < windowSize; x += 105) {
      Die one = new Die(x, y);
      one.show();
      int result = one.rollDie();
      rolls.add(result);
    }
  }
  
  drawGraph(rolls);
}
void mousePressed()
{
  rolls.clear();
  redraw();
}

void keyPressed() {
  rolls.clear();
  redraw();
}

class Die //models one single dice cube
{
  //variable declarations here
  float myRoll, myX, myY;
  
  float dieSize = 100;
  float dotSize = dieSize/5;
  float rounding = 5;
  
  
  Die(int x, int y) //constructor
  {
    //variable initializations here
    myX = (float)x;
    myY = (float)y;
  }
  
  void drawMiddle() {
    ellipse(myX + dieSize/2, myY + dieSize/2, dotSize, dotSize);
  }
  
  void drawCorners(float type) {
    float pos1 = dieSize/4;
    float pos2 = 3*dieSize/4;
    
    if (type == 1) {
      ellipse(myX + pos1, myY + pos2, dotSize, dotSize);
      ellipse(myX + pos2, myY + pos1, dotSize, dotSize);
    } else if (type == 2) {
      ellipse(myX + pos1, myY + pos1, dotSize, dotSize);
      ellipse(myX + pos2, myY + pos2, dotSize, dotSize);
    } else if (type == 3) {
      ellipse(myX + pos1, myY + (pos2 + pos1) / 2, dotSize, dotSize);
      ellipse(myX + pos2, myY + (pos2 + pos1) / 2, dotSize, dotSize);
    }
  }
  
  int rollDie()
  {
    int roll = (int)(Math.random()*6+1);
    
    noStroke();
    fill(230);
    
    if (roll == 1) {
      drawMiddle();
    } else if (roll == 2) {
      drawCorners(1);
    } else if (roll == 3) {
      drawMiddle();
      drawCorners(1);
    } else if (roll == 4) {
      drawCorners(1);
      drawCorners(2);
    } else if (roll == 5) {
      drawCorners(1);
      drawCorners(2);
      drawMiddle();
    } else if (roll == 6) {
      drawCorners(1);
      drawCorners(2);
      drawCorners(3);
    }
    
    return roll;
  }
  void show()
  {
    noStroke();
    fill(180);
    rect(myX, myY, dieSize, dieSize, 5);
    //your code here
  }
}
