String[] lines; //<>//
int count = 0;
int highscore = 0;
PImage miner, factory1, factory2, factory3, research;
String test;
float xpos = 120;
float ypos = 150;
float speed = 1;
char state;


void setup() {
  size(1000, 700);
  lines = loadStrings("words.txt");
  loadHighscore();
  miner = loadImage("Unavngivet.png");
  factory1 = loadImage("Factory.png");
  factory2 = loadImage("Factory2.png");
  factory3 = loadImage("Factory3.png");
  research = loadImage("Research.png");
}

void draw() {
  background(217);
  fill(0);
  
  if (test == null){
    state = 'm';
    if (bitMine()){
      test = "1";
    } else {
      test = "0";
    }
  } else {
    textSize(50);
    text(test, xpos, ypos);
  }
  
  String str = makeString();

  if (str.length()>2) {
    if (findWord(str) == true) {
      count++;
      println(str);
    }
  }

  textSize(100);
  String countStr = nf(count);
  float widthStr = textWidth(countStr);
  text(countStr, width/2-widthStr/2, height/2);
  
  if (count > highscore) {
    highscore = count;
    saveHighscore();
  }
  
  textSize(50);
  String highscoreStr = nf(highscore);
  float highWidthStr = textWidth(highscoreStr);
  text(highscoreStr, width-highWidthStr, 50);
  
  miner.resize(200,200);
  factory1.resize(170,170);
  factory2.resize(170,170);
  factory3.resize(170,170);
  research.resize(200,200);
  image(research, 50, 480);
  image(factory3, 800, 500);
  image(factory1, 400,0);
  image(factory2, 800,30);
  image(miner, 0, 0);
  
  if (state == 'm' || state == 'b') {
    xpos+=speed;
  }
}

boolean findWord(String str) {
  // sæt found til false for hvis den ikke bliver true kan den returneres direkte. Så behøver jeg ikke else
  boolean found=false;
  int i=0;
  //for (int i = 0; i < lines.length; i++) {
  // bliv ved til den er fundet eller at i > længden //<>//
  while (!found && i <lines.length ) {
    if (lines[i].equals(str)) {
      found=true;
    }
    i++;
  }
  return found;
}

String makeString() {
  int strLength = int(random(2, 3));
  String str = "";
  for (int i = 0; i < (strLength+1); i++) {
    char c = makeChar();
    if (i > 0) {
      if (byte(c) > 90) {
        str+=c;
      }
    } else {
      str+=c;
    }
  }
  return str;
}

char makeChar() {
  char c=' ';
  byte d;
  for (int i = 0; true; i++) {
    d = makeByte();
    if ((d > 64 && d < 91) || (d > 96 && d < 123)) {
      c = char(d);
      return c;
    }
  }
}

byte makeByte() {
  byte b = 0;
  for (int i = 0; i<8; i++) {
    if (bitMine()==true) {
      b+=pow(2, i);
    }
  }
  return b;
}

boolean bitMine() {
  if (random(0, 2)>1) {
    return true;
  }
  return false;
}

void loadHighscore() {
  String[] data = loadStrings("highscore.txt");
  if (data.length > 0) {
    highscore = int(data[0]);
  }
}

void saveHighscore() {
  String[] data = {str(highscore)};
  saveStrings("highscore.txt", data);
}
