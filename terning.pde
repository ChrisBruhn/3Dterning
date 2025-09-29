PImage[] sides = new PImage[6];
float angleX = 0, angleY = 0;
float targetX = 0, targetY = 0;
boolean rolling = false;
int result = 1;

void setup() {
  size(800, 800, P3D);
  // hent image filer
  for (int i = 0; i < 6; i++) {
    sides[i] = loadImage("side" + (i+1) + ".png");
  }
}

void draw() {
  background(200);
  lights();

  translate(width/2, height/2, 0);

  // hvis vi er i gang med et kast -> interpoler mod mål
  if (rolling) {
    angleX = lerp(angleX, targetX, 0.1);
    angleY = lerp(angleY, targetY, 0.1);

    // stop når vi er tæt nok på
    if (abs(angleX - targetX) < 0.01 && abs(angleY - targetY) < 0.01) {
      rolling = false;
    }
  }

  rotateX(angleX);
  rotateY(angleY);
  drawDice(100);
}

void drawDice(float s) {
  // Side 1 (front)
  beginShape(QUADS);
  texture(sides[0]);
  vertex(-s, -s, s, 0, 0);
  vertex( s, -s, s, sides[0].width, 0);
  vertex( s, s, s, sides[0].width, sides[0].height);
  vertex(-s, s, s, 0, sides[0].height);
  endShape();

  // Side 6 (bag) – modsat 1
  beginShape(QUADS);
  texture(sides[5]);
  vertex( s, -s, -s, 0, 0);
  vertex(-s, -s, -s, sides[5].width, 0);
  vertex(-s, s, -s, sides[5].width, sides[5].height);
  vertex( s, s, -s, 0, sides[5].height);
  endShape();

  // Side 3 (højre)
  beginShape(QUADS);
  texture(sides[2]);
  vertex( s, -s, s, 0, 0);
  vertex( s, -s, -s, sides[2].width, 0);
  vertex( s, s, -s, sides[2].width, sides[2].height);
  vertex( s, s, s, 0, sides[2].height);
  endShape();

  // Side 4 (venstre) – modsat 3
  beginShape(QUADS);
  texture(sides[3]);
  vertex(-s, -s, -s, 0, 0);
  vertex(-s, -s, s, sides[3].width, 0);
  vertex(-s, s, s, sides[3].width, sides[3].height);
  vertex(-s, s, -s, 0, sides[3].height);
  endShape();

  // Side 2 (top)
  beginShape(QUADS);
  texture(sides[1]);
  vertex(-s, -s, -s, 0, 0);
  vertex( s, -s, -s, sides[1].width, 0);
  vertex( s, -s, s, sides[1].width, sides[1].height);
  vertex(-s, -s, s, 0, sides[1].height);
  endShape();

  // Side 5 (bund) – modsat 2
  beginShape(QUADS);
  texture(sides[4]);
  vertex(-s, s, s, 0, 0);
  vertex( s, s, s, sides[4].width, 0);
  vertex( s, s, -s, sides[4].width, sides[4].height);
  vertex(-s, s, -s, 0, sides[4].height);
  endShape();
}


// Når man klikker -> kast en ny værdi
void mousePressed() {
  result = (int)random(1, 7);

  // bestemme rotationer for de 6 mulige resultater
  switch(result) {
  case 1:
    targetX = 0;
    targetY = 0;
    break; // front
  case 2:
    targetX = -HALF_PI;
    targetY = 0;
    break; // bag
  case 3:
    targetX = 0;
    targetY = -HALF_PI;
    break; // højre
  case 4:
    targetX = 0;
    targetY = HALF_PI;
    break; // venstre
  case 5:
    targetX = HALF_PI;
    targetY = 0;
    break; // top
  case 6:
    targetX = 0;
    targetY = PI;


    break; // bund
  }

  rolling = true;
  println("Du slog: " + result);
}
