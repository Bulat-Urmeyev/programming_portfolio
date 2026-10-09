// Bulat Urmeyev | 15 Sept 2026 | Calculator //<>// //<>//
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
float l, r, result;
char op;
boolean left;
boolean newEntry;
String displayVal;
long fact_num;

void setup() {
  size(300, 450);
  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = ' ';
  displayVal = "0.0";
  left = true;
  newEntry = true;
  fact_num = 0;
  numButtons[9] = new Button(180, 160, 50, 50, '9');
  numButtons[8] = new Button(120, 160, 50, 50, '8');
  numButtons[7] = new Button(60, 160, 50, 50, '7');
  numButtons[6] = new Button(180, 220, 50, 50, '6');
  numButtons[5] = new Button(120, 220, 50, 50, '5');
  numButtons[4] = new Button(60, 220, 50, 50, '4');
  numButtons[3] = new Button(180, 280, 50, 50, '3');
  numButtons[2] = new Button(120, 280, 50, 50, '2');
  numButtons[1] = new Button(60, 280, 50, 50, '1');
  numButtons[0] = new Button(60, 340, 50, 50, '0');
  opButtons[0] = new Button(120, 400, 50, 50, '^');
  opButtons[1] = new Button(240, 160, 50, 50, '+');
  opButtons[2] = new Button(240, 220, 50, 50, '-');
  opButtons[3] = new Button(240, 280, 50, 50, 'x');
  opButtons[4] = new Button(240, 340, 50, 50, '÷');
  opButtons[5] = new Button(120, 340, 50, 50, '.');
  opButtons[6] = new Button(240, 100, 50, 50, 'C');
  opButtons[7] = new Button(240, 40, 50, 50, '±');
  opButtons[8] = new Button(180, 340, 50, 50, '=');
  opButtons[9] = new Button(60, 400, 50, 50, '√');
  opButtons[10] = new Button(180, 400, 50, 50, '!');
  opButtons[11] = new Button(240, 400, 50, 50, 'T');
}

void draw() {
  background(33);
  drawDisplay();
  for (int i = 0; i<numButtons.length; i++) {
    textSize(18);
    numButtons[i].display();
    numButtons[i].mouseOver(mouseX, mouseY);
  }
  for (int i = 0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].mouseOver(mouseX, mouseY);
  }
}

void drawDisplay() {
  rectMode(CENTER);
  rect(120, 60, 160, 80);
  fill(1);
  textSize(45);
  text(displayVal, 120, 70);
}

void mouseReleased() {
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover) {
      handleEvent(numButtons[i].val, true);
    }
  }
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover) {
    }
  }

  println("L: " + l);
  println("R: " + r);
  println("Result: " + result);
  println("Left: " + left);
  println("Op: " + op);
}

void performCalc() {
  println("inside perfromCalc");
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '÷') {
    result = l / r;
  } else if (op == 'x') {
    result = l * r;
  } else if (op == '^') {
    result = pow(l, r);
  }
  displayVal = str(result);
  left = !left;
  l = result;
}

float calcFactorial(int n) {
  if (n < 0) return 0;
  float ans = 1;
  for (int i = 1; i <= n; i++) {
    ans *= i;
  }
  return ans;
}

void keyPressed() {
    println("keyCode: " + keyCode);
  if (keyCode == 49 || keyCode == 97) {
    handleEvent('1', true);
  } else if (keyCode == 50 || keyCode == 98) {
    handleEvent('2', true);
  } else if (keyCode == 51 || keyCode == 99) {
    handleEvent('3', true);
  } else if (keyCode == 52 || keyCode == 100) {
    handleEvent('4', true);
  } else if (keyCode == 53 || keyCode == 101) {
    handleEvent('5', true);
  } else if (keyCode == 54 || keyCode == 102) {
    handleEvent('6', true);
  } else if (keyCode == 55 || keyCode == 103) {
    handleEvent('7', true);
  } else if (keyCode == 56 || keyCode == 104) {
    handleEvent('8', true);
  } else if (keyCode == 57 || keyCode == 105) {
    handleEvent('9', true);
  }else if (keyCode == 48 || keyCode == 96) {
    handleEvent('0', true);
  }else if (keyCode == 45 || keyCode == 109) {
    handleEvent('-', false);
  }else if (keyCode == 107) {
    handleEvent('+', false);
  }else if (keyCode == 47 || keyCode == 111) {
    handleEvent('÷', false);
  }else if (keyCode == 10) {
    handleEvent('=', false);
  }
}

void handleEvent(char val, boolean isNum) {
  if (isNum == true) {
    // Do num stuff
    String digit = str(val);
    if (newEntry || displayVal.equals("0.0")) {
      displayVal = digit;
      newEntry = false;
    } else {
      displayVal += digit;
    }

    if (left) {
      l = float(displayVal);
    } else {
      r = float(displayVal);
    }
  } else {
    char clicked = opButtons[val].val;
    if (opButtons[val].val == '=') {
      performCalc();
    } else if (clicked == '+' || clicked == '-' ||
      clicked == 'x' || clicked == '÷' || clicked == '^') {
      op = clicked;
      left = !left;
      newEntry = true;
      displayVal = str(op);
    } else if (clicked == '±') {
      if (left) {
        l *= -1;
        displayVal = str(l);
      } else {
        r *= -1;
        displayVal = str(r);
      }
    } else if (clicked == 'C') {
      l = 0.0;
      r = 0.0;
      result = 0.0;
      op = ' ';
      displayVal = "0.0";
      left = true;
      newEntry = true;
    } else if (clicked == '√') {
      if (left) {
        l = sqrt(l);
        displayVal = str(l);
      } else {
        r = sqrt(r);
        displayVal = str(r);
      }
      newEntry = true;
    } else if (clicked == 'S') {
      if (left) {
        l = sin(l);
        displayVal = str(l);
      } else {
        r = sin(r);
        displayVal = str(r);
      }
      newEntry = true;
    } else if (clicked == 'T') {
      if (left) {
        l = tan(l);
        displayVal = str(l);
      } else {
        r = tan(r);
        displayVal = str(r);
      }
      newEntry = true;
    } else if (clicked == '!') {
      if (left) {
        l = calcFactorial(int(l));
        displayVal = str(l);
      } else {
        r = calcFactorial(int(r));
        displayVal = str(r);
      }
      newEntry = true;
    } else if (clicked == '.') {
      if (!displayVal.contains(".")) {
        displayVal += ".";
      }
    }
  }
}
