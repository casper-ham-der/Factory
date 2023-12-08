String[] lines; //<>// //<>//
int count = 0;
int highscore = 0;
PImage miner, factory1, factory2, factory3, research;
String test;
StringList Mi;
StringList MiBy;
StringList By;
float speed = 3.5;
char state;
int check1 = 0;
int check2 = 0;
boolean by = false;
int interval = 0;


void setup() {
  size(1000, 700);
  Mi = new StringList();
  MiBy = new StringList();
  By = new StringList();
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

  if (check1 >= (30/speed)) {
    int i;
    if (bitMine()) {
      i = 1;
    } else {
      i = 0;
    }
    Mi.append(String.valueOf(i));
    check1 = 0;
  }
    check1++;
  println(Mi);
  
  if (120+((Mi.size()-(0+1))*(30/speed)+check1)*speed >= 420){
    MiBy.append(Mi.get(0));
    Mi.remove(0);
  }
  if (MiBy.size() == 8){
    by = true;
    interval = check2;
    println(MiBy);
    byte b = makeByte(int(MiBy.get(0)),int(MiBy.get(1)),int(MiBy.get(2)),int(MiBy.get(3)),int(MiBy.get(4)),int(MiBy.get(5)),int(MiBy.get(6)),int(MiBy.get(7)));
    By.append(String.valueOf(b));
    MiBy = new StringList();
    println(By);
  } else if (by){
    check2++;
  }
  
  if (500+(check2-((31/speed)*8)*0)*speed >= 820){
    check2-=(31/speed)*8;
    By.remove(0);
  }

  textSize(50);
  for (int i = 0; i<Mi.size(); i++) {
    text(Mi.get(i),120+((Mi.size()-(i+1))*(30/speed)+check1)*speed,150);
  }
  for (int i = 0; i<By.size(); i++) {
    text(By.get(i),500+(check2-((31/speed)*8)*i)*speed,150);
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

  miner.resize(200, 200);
  factory1.resize(170, 170);
  factory2.resize(170, 170);
  factory3.resize(170, 170);
  research.resize(200, 200);
  image(research, 50, 480);
  image(factory3, 800, 500);
  image(factory1, 400, 0);
  image(factory2, 800, 30);
  image(miner, 0, 0);
}

boolean findWord(String str) {
  // sæt found til false for hvis den ikke bliver true kan den returneres direkte. Så behøver jeg ikke else
  boolean found=false;
  int i=0;
  //for (int i = 0; i < lines.length; i++) {
  // bliv ved til den er fundet eller at i > længden
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
  //byte d;
  //for (int i = 0; true; i++) {
   // d = makeByte();
   // if ((d > 64 && d < 91) || (d > 96 && d < 123)) {
    //  c = char(d);
      return c;
  //  }
 // }
}

byte makeByte(int i1, int i2, int i3, int i4, int i5, int i6, int i7, int i8) {
  byte b = 0;
  b+=pow(2, 0)*i1+pow(2, 1)*i2+pow(2, 2)*i3+pow(2, 3)*i4+pow(2, 4)*i5+pow(2, 5)*i6+pow(2, 6)*i7+pow(2, 7)*i8;
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
