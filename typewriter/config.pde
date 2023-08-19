// xArm Coordinate Configuration
float x, y = 0;
float x_processing, y_processing;
float x_robot, y_robot; 
float z_robot = 82; // shift to tune pen height relative to paper
int real_height = 280; // Letter-Sized Paper Height
int real_width = 216; // Letter-Sized Paper Width
int robot_x_offset = 680; // X of top left coordinate where xArm should start typing. 

//Font & Spacing Customization
String font = "Times"; 
//Change this to change font selection. 
// to add custom font, look below or go to https://npothu.github.io/posts/xArmTypewriter/
String font_file = "Fonts/"+font+".csv";
int txtSize = 120;
int margin = 15;
//int gap = 15;
float space = 2;
int line_space_offset = 0; // Increase this value if characters collide vertically 

// Add an else if statement in the following function with your conditions to add a new font
void fontSelector(){
if (font == "Times"){
  num_chars = 94;
  curves = 135;
  starting_ascii = 33;
  points_per_curve = 50;
  has_five_curves = new int[]{37}; //%
  has_four_curves = new int[]{};
  has_three_curves = new int[]{36, 38, 56, 66, 103}; // $, &, 8, g, B
  has_two_curves = new int[]{33, 34, 35, 48, 52, 54, 57, 58, 59, 61, 63, 64, 65, 68, 79, 80, 81, 82, 97, 98, 100, 101, 105, 106, 111, 112, 113};
  // !,",#,0,4,6,9,:,;,=,?,@,A,D,O,P,Q,R,a,b,d,e,i,j,o,p,q
} else if (font == "CourierNew"){
  num_chars = 94;
  curves = 131;
  starting_ascii = 33;
  points_per_curve = 50;
  has_five_curves = new int []{37}; //%
  has_four_curves = new int []{};
  has_three_curves = new int[]{46,66}; //8B
  has_two_curves = new int[]{33,34,35,38,48,52,54,57,58,59,61,63,64,65,68,79,80,81,82,97,98,100,101,103,105,106,111,112,113};
  //!"#&0469:;=?@ADOPQRabdegijopq
}
}

// Initializing Font Settings
int num_chars;
int curves;
int starting_ascii;
int points_per_curve;
int[] has_five_curves = new int[100];
int[] has_four_curves = new int[100];
int[] has_three_curves = new int[100];
int[] has_two_curves = new int[100];
ArrayList<ArrayList<ArrayList<Float>>> Letters = new ArrayList<>(num_chars);
int TextLength = 0;
int polyChar;
int Text;
PrintWriter output;
boolean first_run = true; // stops draw() from completeing an action when first run program.
float spacing = 0;
