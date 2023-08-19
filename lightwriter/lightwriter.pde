float x, y = 0;
float x_processing, y_processing;
float z_robot, y_robot;
float x_robot = 250;
int real_height = 280; //280
int real_width = 216; //216
int z_robot_offset = 400;


//Font & Spacing Customization
String font_file = "Fonts/Times.csv";
int txtSize = 70;
int margin = 15;
//int gap = 15;
float space = 2;

// ***IMPORTANT** txt/csv file configuration
int num_chars = 94;
int curves = 135;
int starting_ascii = 33;
int points_per_curve = 50;
int has_five_curves = 37; //%
int[] has_three_curves = new int[]{36, 38, 56, 66, 103};
// $, &, 8, g, B
int[] has_two_curves = new int[]{33, 34, 35, 48, 52, 54, 57, 58, 59, 61, 63, 64, 65, 68, 79, 80, 81, 82, 97, 98, 100, 101, 105, 106, 111, 112, 113};
//!,",#,0,4,6,9,:,;,=,?,@,A,D,O,P,Q,R,a,b,d,e,i,j,o,p,q

// Code Stuff
ArrayList<ArrayList<ArrayList<Float>>> Letters = new ArrayList<>(num_chars);
int TextLength = 0;
int polyChar;
int Text;
PrintWriter output;
boolean first_run = true; // temp solution to stop draw() from completiting an action when first run program.
float spacing = 0;



void setup() {
  size(500, 500);
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
      
      z_robot = -y_processing + z_robot_offset; // remove the -90 after
      y_robot = -x_processing - 250; // not known yet
      output.println(500 + "," + y_robot + ',' + z_robot);
      
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
    if (i + starting_ascii == has_five_curves) {
      Letters.add(new ArrayList<ArrayList<Float>>(points_per_curve*5));
      for (j = 0; j < points_per_curve*5; j++) {
        Letters.get(i).add(new ArrayList<Float>(2));
        tot++;
      }
      five++;
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
  //println(one, two, three, five, tot);

  // Filling in array w/ points
  String[] txt_array = loadStrings(font_file);
  int num = 0;
  for (int letter = 0; letter < num_chars; letter++) {

    if (letter + starting_ascii == has_five_curves) {

      for (int dot = 0; dot < points_per_curve*5; dot++) {
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
    y += txtSize/2*1.2;
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
