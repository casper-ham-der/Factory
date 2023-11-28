String[] lines;

void setup() {
  size(800,800);
  lines = loadStrings("words.txt"); 
}

void draw() { 
  println(findWord(makeString()));
}

boolean findWord(String str) {
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].equals(str)){
    } else {
      return false;
    }
  }
  return true;
}

String makeString() {
  int strLength = int(random(2,52));
  String str = "";
  for (int i = 0; i < (strLength+1); i++){
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
