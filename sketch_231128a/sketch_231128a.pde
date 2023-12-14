/* //<>//
Det er ret vildt hvad du har lavet!!
4 ting! 
1) Du skal gøre din kode mere genetisk. Med det mener jeg at dine funktioner skal kunne bruges i flere tilfælde. Mange af dine funktioner motager en lang række af parameter. fx c1,c2,c3 etc. Det gør at funktionen kun kan bruges i et spcifikt tilfælde. Brug et loop og lav en funktion som kun modtager én parameter. Så er det lettere at genbruge.  
2) Der mangler kommentarer i din kode! Forklar for læseren hvad du gør.
3) Ungå for mange globale variabler (det kan være svært) bliver lettere når vi lærer at lave det OOP
4) Tommelfinger regl for hvor mange linjer som er i en funktion er 7 !! Kommer man over det skal man overveje at lave en ny funktion.
*/

String[] lines;
int count = 0;
int fails = 0;
int fails2 = 1;
int highscore = 0;
PImage miner, factory1, factory2, factory3, research;
String test;
StringList Mi = new StringList();
StringList MiBy = new StringList();
StringList By = new StringList();
StringList Ch = new StringList();
StringList ChSt = new StringList();
StringList St = new StringList();
FloatList xBy = new FloatList();
FloatList yCh = new FloatList();
FloatList xSt = new FloatList();
FloatList grafy = new FloatList();
FloatList grafx = new FloatList();
float speed = 0;
char state;
float interval = 8;
int check1 = 0;
int check2 = 0;
boolean by = false;
float xpos = 200;
boolean pressed = false;
boolean presseds = false;
boolean main = true;
int overcount = 0;

void setup() {
  size(1000, 800);
  lines = loadStrings("words.txt");
  loadHighscore();
  miner = loadImage("Unavngivet.png");
  factory1 = loadImage("Factory.png");
  factory2 = loadImage("Factory2.png");
  factory3 = loadImage("Factory3.png");
  research = loadImage("Research.png");
  frameRate(120);
}

void draw() {
  background(217);
  fill(0);

  if (check1 >= (interval/speed)) {
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

  if (120+((Mi.size()-(0+1))*(interval/speed)+check1)*speed >= 420) {
    MiBy.append(Mi.get(0));
    Mi.remove(0);
  }
  if (MiBy.size() == 8) {
    by = true;
    byte b = makeByte(int(MiBy.get(0)), int(MiBy.get(1)), int(MiBy.get(2)), int(MiBy.get(3)), int(MiBy.get(4)), int(MiBy.get(5)), int(MiBy.get(6)), int(MiBy.get(7)));
    By.append(String.valueOf(b));
    xBy.append(480);
    MiBy = new StringList();
  } else if (by) {
    check2++;
  }

  if (xBy.size() > 0) {
    if (xBy.get(0) >= 820) {
      char c = makeChar(byte(int(By.get(0))));
      if (c != ' ') {
        Ch.append(String.valueOf(c));
        yCh.append(150);
      } else {
        if (fails2 == 3) {
          fails++;
          fails2 = 0;
        }
        fails2++;
      }
      By.remove(0);
      xBy.remove(0);
    }
  }

  if (yCh.size() > 0) {
    if (yCh.get(0) >= 650) {
      ChSt.append(Ch.get(0));
      Ch.remove(0);
      yCh.remove(0);
    }
  }
  if (ChSt.size() == 3) {
    St.append(makeString(ChSt.get(0), ChSt.get(1), ChSt.get(2)));
    xSt.append(840);
    ChSt = new StringList();
  }

  if (xSt.size() > 0) {
    if (xSt.get(0)<= 100) {
      if (findWord(St.get(0))) {
        count++;
      } else {
        fails++;
      }
      St.remove(0);
      xSt.remove(0);
    }
  }

  if (main) {
    textSize(50);
    for (int i = 0; i<Mi.size(); i++) {
      text(Mi.get(i), 120+((Mi.size()-(i+1))*(interval/speed)+check1)*speed, 150);
    }
    for (int i = 0; i<By.size(); i++) {
      text(By.get(i), xBy.get(i), 150);
    }
    for (int i = 0; i<Ch.size(); i++) {
      text(Ch.get(i), 840, yCh.get(i));
    }
    for (int i = 0; i<St.size(); i++) {
      text(St.get(i), xSt.get(i), 640);
    }


    textSize(70);
    String countStr = "Fundne ord: "+nf(count);
    float widthStr = textWidth(countStr);
    text(countStr, width/2-widthStr/2, height/2-100);

    textSize(60);
    String failsStr = "Fejl: "+nf(fails);
    float widthfails = textWidth(failsStr);
    text(failsStr, width/2-widthfails/2, height/2);


    if (fails > 0) {
      float rate = (float(count)*100)/float(fails);
      int lengths = 0;
      for (int i = 0; i < nf(rate).length(); i++) {
        if (nf(rate).charAt(i) == '.') {
          lengths = i;
          break;
        }
      }
      boolean comma = false;
      for (int i = 0; i < 3 && i+lengths+2 < nf(rate).length(); i++) {
        if (int(nf(rate).charAt(i+lengths+2)) > 0) {
          comma = true;
          break;
        }
      }

      if (comma) {
        float widthSuccesrate = textWidth("Succesrate: "+nf(rate, lengths+1, 2)+"%");
        text( "Succesrate: "+nf(rate, lengths, 2)+"%", width/2-widthSuccesrate/2, height/2+80);
      } else {
        float widthSuccesrate = textWidth("Succesrate: "+nf(rate, lengths+1, 0)+"%");
        text( "Succesrate: "+nf(rate, lengths, 0)+"%", width/2-widthSuccesrate/2, height/2+80);
      }
    } else {
      String succesrate = "Succesrate: "+nf(0)+"%";
      float widthSuccesrate = textWidth(succesrate);
      text( "Succesrate: "+nf(0)+"%", width/2-widthSuccesrate/2, height/2+80);
    }


    if (count > highscore) {
      highscore = count;
      saveHighscore();
    }

    textSize(50);
    String highscoreStr = nf(highscore);
    float highWidthStr = textWidth(highscoreStr);
    text(highscoreStr, width-highWidthStr, 50);

    textSize(50);
    text("Fart:", 80, 760);

    miner.resize(200, 200);
    factory1.resize(170, 170);
    factory2.resize(170, 170);
    factory3.resize(170, 170);
    research.resize(200, 200);
    image(research, 50, 500);
    image(factory3, 800, 500);
    image(factory1, 400, 0);
    image(factory2, 800, 30);
    image(miner, 0, 0);

    text("Graf", 850, 760);
  } else {

    stroke(255, 0, 0);
    strokeWeight(5);

    for (int i = 0; i < grafx.size()-1; i++) {
      line(grafx.get(i)+50, grafy.get(i), grafx.get(i+1)+50, grafy.get(i+1));
    }

    stroke(0);
    strokeWeight(1);

    text("Fabrik", 830, 760);
  }

  textSize(50);
  text("Fart:", 80, 760);

  noFill();
  rect(820, 710, 150, 70);

  fill(0);
  rect(200, 747, 600, 5);
  fill(65, 134, 244);
  rect(xpos, 737, 10, 25);

  if (mousePressed) {
    if (pressed) {
      if (mouseX < 205) {
        xpos = 200;
      } else if (mouseX > 800) {
        xpos = 795;
      } else {
        xpos = mouseX-5;
      }
    } else if (mouseX > 205 && mouseX < 800 && mouseY > 737 && mouseY < 737+25) {
      xpos = mouseX-5;
      pressed = true;
      presseds = true;
    }
    if (presseds == false) {
      if (mouseX > 820 && mouseX < 970 && mouseY > 710 && mouseY < 780) {
        presseds = true;
        if (main) {
          main = false;
        } else {
          main = true;
        }
      }
    }
  } else {
    pressed = false;
    presseds = false;
  }

  speed = (xpos - 205)/(795-205)*(50-3.5)+3.5;

  for (int i = 0; i < xBy.size(); i++) {
    xBy.add(i, speed/2);
  }
  for (int i = 0; i < yCh.size(); i++) {
    yCh.add(i, speed/2);
  }
  for (int i = 0; i < xSt.size(); i++) {
    xSt.add(i, -speed/3);
  }

  if (fails > 0) {
    grafx.append(overcount/60);
    overcount++;
    grafy.append(height - (count*10000)/fails - 150);
  }
}

boolean findWord(String str) {
  boolean found=false;
  int i=0;
  while (!found && i <lines.length ) {
    if (lines[i].equals(str)) {
      found=true;
    }
    i++;
  }
  return found;
}

// c1 c2 c3 gør det svært at læse! 
String makeString(String c1, String c2, String c3) {
  String str="";
  str+=c1+c2+c3;
  return str;
}


// den burde ikke hedde makeChar. testChar() eller checkChar() ??? for den tester om char er inden for ascii værdierne 
char makeChar(byte b) {
  char c=' ';
  if ((b > 64 && b < 91) || (b > 96 && b < 123)) {
    c = char(b);
  }
  return c;
}


// der er rigtig mange parameter til din funktion og variabel navne med et bogstav gør det svært at læse. Brug en løkke i stedet!
byte makeByte(int i1, int i2, int i3, int i4, int i5, int i6, int i7, int i8) {
  byte b = 0;
  b+=pow(2, 0)*i1+pow(2, 1)*i2+pow(2, 2)*i3+pow(2, 3)*i4+pow(2, 4)*i5+pow(2, 5)*i6+pow(2, 6)*i7+pow(2, 7)*i8;
  return b;
  /* og så kan du bruge i som eksponent.
  for (int i=8;i>0;i--){
    if(bitMine()){
      b+=pow(2, i);
    }
  }
  */
  
  
}

boolean bitMine() {
  /*
  if (random(0, 2)>1) {
    return true;
  }
  return false;
  */
  // kig lige på det her: 
  return (random(0, 2)>1);
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
