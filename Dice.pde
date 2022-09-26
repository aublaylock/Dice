ArrayList<Die> dice;

void setup() {
  size(1000, 1000, P3D);
  dice = new ArrayList();
  fill(0,0,0);
}

void draw() {
  background(250, 250, 250);
  int total = 0;
  for (Die die: dice) {
    die.show();
    if (!die.isSpinning()) {
      total += die.getVal();
    }
  }
  //resetMatrix();
  textSize(128);
  text("Total: " + total, 40, 120);
  
}

void mousePressed() {
  Die die = new Die(mouseX, mouseY);
  dice.add(die);
}


public class Die //models one single die
{
  //member variable declarations here
  int frame, x, y, val;
  final int lastSpinningFrame = (int)(Math.random()*100)+25;
  boolean[][] dots;

  Die(int dieX, int dieY) //constructor
  {
    //variable initializations here
    frame = 0;
    x = dieX;
    y = dieY;
    val = (int)(Math.random()*6)+1;
    dots = new boolean[3][3];
    //Make Face(2d array)
    if (val==1 || val==3 || val==5) {
      dots[1][1] = true;
    }
    if (val != 1) {
      dots[0][2] = true;
      dots[2][0] = true;
    }
    if (val>3) {
      dots[0][0] = true;
      dots[2][2] = true;
    }
    if (val==6) {
      dots[1][0] = true;
      dots[1][2] = true;
    }
  }
  
  private void show()
  {
    pushMatrix();
    frame++;
    noFill();
    translate(x, y, -100);
    if (frame < lastSpinningFrame) {
      rotateZ(frame/0.2);
      rotateY(frame/0.3);
      box(200);
    } else {
      box(200);
      
      translate(-x, -y, 100);
      fill(255,255,255);
      rect(x-95, y-95, 190, 190);
      fill(0, 0, 0);
      translate(0,0,1);
      for (int a = 0; a<3; a++) {
        for (int b = 0; b<3; b++) {
          if (dots[a][b]) {
            ellipse(x+(b-1)*50, y+(a-1)*50, 40, 40);
          }
        }
      }
    }
    popMatrix();
  }
  
  int getVal() {
    return (val);
  }
  
  boolean isSpinning() {
    return (frame <= lastSpinningFrame);
  }
}
