void setup() {
  fontSelector();
  size(400, 400);
  background(0);
  output = createWriter("positions.csv");
  createArray();
  // Initializes 3D ArrayList to match char/point/x-y-coords
  // then fills array with char/point/x-y-coords using populateArray()
}


void draw() {
  stroke(255);
  translate(0, margin*2.5);
  if (first_run == false) {
    spacing = 0;
    for (int i = 0; i < Letters.get(polyChar).size(); i++) {
      x_processing = txtSize*Letters.get(polyChar).get(i).get(0)+x;
      y_processing = -txtSize*Letters.get(polyChar).get(i).get(1)+y;
      point(x_processing, y_processing);
      
      x_robot = -y_processing+robot_x_offset; // remove the -90 after
      y_robot = -x_processing + 216; // not known yet
      output.println(x_robot + "," + y_robot + ',' + z_robot);
      
      if (txtSize*Letters.get(polyChar).get(i).get(0) > spacing) {
        spacing = txtSize*Letters.get(polyChar).get(i).get(0);
      }
    }
    output.flush();
  } else {
    first_run = false;
    x=margin;
  }
  noLoop();
}


void createArray() {

  // Initalizing Array
  int one = 0;
  int two = 0;
  int three = 0;
  int five = 0;
  int tot = 0;
  int i, j;
  for (i = 0; i < num_chars; i++) {
    if (contains(has_five_curves, i + starting_ascii)) {
      Letters.add(new ArrayList<ArrayList<Float>>(points_per_curve*5));
      for (j = 0; j < points_per_curve*5; j++) {
        Letters.get(i).add(new ArrayList<Float>(2));
        tot++;
      }
      five++;
    } else if (contains(has_four_curves, i + starting_ascii)) {
      Letters.add(new ArrayList<ArrayList<Float>>(points_per_curve*4));
      for (j = 0; j < points_per_curve*4; j++) {
        Letters.get(i).add(new ArrayList<Float>(2));
        tot++;
      }
    } else if (contains(has_three_curves, i + starting_ascii)) {
      Letters.add(new ArrayList<ArrayList<Float>>(points_per_curve*3));
      for (j = 0; j < points_per_curve*3; j++) {
        Letters.get(i).add(new ArrayList<Float>(2));
        tot++;
      }
      three++;
    } else if (contains(has_two_curves, i + starting_ascii)) {
      Letters.add(new ArrayList<ArrayList<Float>>(points_per_curve*2));
      for (j = 0; j< points_per_curve*2; j++) {
        Letters.get(i).add(new ArrayList<Float>(2));
        tot++;
      }
      two++;
    } else {
      Letters.add(new ArrayList<ArrayList<Float>>(points_per_curve));
      for (j = 0; j< points_per_curve; j++) {
        Letters.get(i).add(new ArrayList<Float>(2));
        tot++;
      }
      one++;
    }
  }
  println(one, two, three, five, tot);

  // Filling in array w/ points
  String[] txt_array = loadStrings(font_file);
  //String[] dotCoords;
  int num = 0;
  for (int letter = 0; letter < num_chars; letter++) {

    if (contains(has_five_curves, letter + starting_ascii)) {

      for (int dot = 0; dot < points_per_curve*5; dot++) {
        populateArray(txt_array, num, letter, dot);
        num++;
      }
      five++;
    }else if (contains(has_four_curves, letter + starting_ascii)) {

      for (int dot = 0; dot < points_per_curve*4; dot++) {
        populateArray(txt_array, num, letter, dot);
        num++;
      }
      five++;
    } else if (contains(has_three_curves, letter + starting_ascii)) {
      for (int dot = 0; dot < points_per_curve*3; dot++) {
        populateArray(txt_array, num, letter, dot);
        num++;
      }
      three++;
    } else if (contains(has_two_curves, letter + starting_ascii)) {
      for (int dot = 0; dot < points_per_curve*2; dot++) {
        populateArray(txt_array, num, letter, dot);
        num++;
      }
    } else {
      for (int dot = 0; dot < points_per_curve; dot++) {
        populateArray(txt_array, num, letter, dot);
        num++;
      }
    }
    //For troubleshooting: println("Character " + char(letter + starting_ascii) + ":" + letter);
  }
}

boolean contains(final int[] array, final int key) {
  for (final int i : array) {
    if (i == key) {
      return true;
    }
  }
  return false;
}

void populateArray(final String[] txt_array, int num, int letter, int dot) {
  String[] dotCoords = txt_array[num].split(", ", 3);
  x = float(dotCoords[0].replace("{", ""));
  y = float(dotCoords[1]);
  Letters.get(letter).get(dot).add(0, x);
  Letters.get(letter).get(dot).add(1, y);
}

void keyPressed() {
  background(0);
  if (key==ESC) {
    output.flush();
    output.close();
    exit();
  } else if (key == 32) {
    x+=txtSize/2;
    //spacing = 0;
  }
  if (txtSize + x > width - margin) {
    y += txtSize/1.5 + line_space_offset;
    x = margin;
    spacing = 0;
  }
  Text = int(key);
  polyChar = Text-starting_ascii;

  if (polyChar >= 0 & polyChar <= num_chars) {
    x+=spacing+space;
    loop();
  }
}

