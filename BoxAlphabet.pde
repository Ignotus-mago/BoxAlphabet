/**
 BoxAlphabet
 @author Paul Hertz
 Generates and displays a 26-character graphic alphabet using a 7x7 grid. 
 All characters at most two rectangles superimposed on a background square.
 */
 
import net.paulhertz.aifile.*;
import net.paulhertz.geom.*;
import net.paulhertz.util.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
 
HashMap<String, IntList> boxList;
color alphaBackColor1;
color alphaBackColor2;
color alphaForeColor1;
color alphaForeColor2;
color spaceColor1;
color spaceColor2;
int sxy = 8;
int d = 64;
boolean testing = false;

IgnoCodeLib igno;

boolean oneShot = true;
GroupComponent messageGroup;
GroupComponent alphaGroup;
DocumentComponent document;


 public void setup() {
   size(1024, 1024);
   igno = new IgnoCodeLib(this);
   initBoxAlpha();
   setupGeometry();
 }
 
 public void setupGeometry() {
   alphaBackColor1 = color(21, 34, 55);
   alphaBackColor2 = color(89, 110, 233);
   alphaForeColor1 = color(233, 233, 47);
   alphaForeColor2 = color(199, 34, 42);
   alphaGroup = loadAlphabet();
   alphaGroup.hide();
   alphaBackColor1 = color(254, 251, 246);
   alphaBackColor2 = color(254, 246, 233);
   alphaForeColor1 = color(199, 34, 42);
   alphaForeColor2 = color(55, 89, 144);
   spaceColor1 = color(254, 199, 21);
   spaceColor2 = color(233, 178, 34);
   String msg;
   msg = "Oblivion is not to be hired: The greater part must be content to be as though they had not been," 
    + "to be found in the Register of God, not in the record of man. Twenty seven Names make up the first story," 
    + "and the recorded names ever since contain not one living Century. The number of the dead long exceedeth" 
    + "all that shall live. The night of time far surpasseth the day, and who knows when was the Equinox?" 
    + "Every houre addes unto that current Arithmetique, which scarce stands one moment. And since death must be the " 
    + "Lucina of life, and even Pagans could doubt whether thus to live, were to dye. Since our longest" 
    + "Sunne sets at right descensions, and makes but winter arches, and therefore it cannot be long before" 
    + "we lie down in darknesse, and have our lights in ashes. Since the brother of death daily haunts us" 
    + "with dying mementos, and time that grows old it self, bids us hope no long duration: Diuturnity i" 
    + "a dream and folly of expectation.";
   messageGroup = loadMessage(msg);
   println("----->>> Press spacebar to change display. <<<-----");
   println("----->>> Press 's' to save to Adobe Illustrator file. <<<-----");
 }
 
 public void draw() {
   background(144,157,186);
   alphaGroup.draw();
   messageGroup.draw();
 }
 
 public void keyPressed() {
   if (key == ' ') {
     if (alphaGroup.isVisible()) {
       alphaGroup.hide();
       messageGroup.show();
     }
     else {
       alphaGroup.show();
       messageGroup.hide();
     }
   }
   else if (key == 's' || key == 'S') {
     println("----->>> SAVING ");
     saveAI("message+alphabet.ai"); 
   }
 }
 
 
 public GroupComponent loadAlphabet() {
   float startX = 64;
   float startY = 64;
   float scaleXY = 2 * sxy;
   float tx = startX;
   float xinc = scaleXY * 8;
   float ty = startY;
   float yinc = scaleXY * 8;
   int rowCount = 5;
   int i = 0;
   GroupComponent aGroup = new GroupComponent();
   for (IntList bal : boxList.values()) {
     GroupComponent g = loadChar(bal, scaleXY, tx, ty);
     aGroup.add(g);
     tx += xinc;
     i++;
     if (i >= rowCount) {
       i = 0;
       ty += yinc;
       tx = startX;
     }
   }
   return aGroup;
 }
 
 public GroupComponent loadMessage(String mess) {
   String[] words = mess.toUpperCase().split(" ");
   float startX = 32;
   float startY = 64;
   float scaleXY = sxy * 0.5;
   float tx = startX;
   float xinc = scaleXY * 7;
   float ty = startY;
   float yinc = scaleXY * 7;
   int breakWord = 9;
   int charCount = 0;
   GroupComponent g;
   GroupComponent messGroup = new GroupComponent();
   Pattern pattern = Pattern.compile("[A-Z]+");
   for (int i = 0; i < words.length; i++) {
     String src = words[i];
     Matcher matcher = pattern.matcher(src);
     if (matcher.find()) {
       String word = matcher.group();
       if (testing) println(word);
       int n = 0;
       for (n = 0; n < word.length(); n++) {
         String ch = str(word.charAt(n));
         IntList bal = boxList.get(ch);
         color c1 = charCount % 2 == 0 ? alphaBackColor1 : alphaBackColor2;
         color c2 = charCount % 2 == 0 ? alphaForeColor1 : alphaForeColor2;
         charCount++;
         g = loadChar(bal, scaleXY, tx, ty, c2, c1);
         messGroup.add(g);
         tx += xinc;
       }
       IntList bal = boxList.get(" ");
       color c1 = charCount % 2 == 0 ? spaceColor1 : spaceColor2;
       color c2 = charCount % 2 == 0 ? alphaBackColor1 : alphaBackColor2;
       charCount++;
       g = loadChar(bal, scaleXY, tx, ty, c2, c1);
       tx += xinc;
       if (tx > width - breakWord * xinc) {
         tx = startX;
         ty += yinc;
         charCount = 0;
         int temp = alphaBackColor1;
         alphaBackColor1 = alphaBackColor2;
         alphaBackColor2 = temp;
         temp = alphaForeColor1;
         alphaForeColor1 = alphaForeColor2;
         alphaForeColor2 = temp;
         temp = spaceColor1;
         spaceColor1 = spaceColor2;
         spaceColor2 = temp;
       }
       else {
         messGroup.add(g);
       }
     }
   }
   return messGroup;
 }
 
 
 public GroupComponent loadChar(IntList bal, float scaleXY, float tx, float ty) {
   int[] coords = bal.array();
   int i = 0;
   GroupComponent g = new GroupComponent();
   BezRectangle r0 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
   r0.setNoStroke();
   r0.setFillColor(alphaBackColor1);
   r0.scaleShape(scaleXY, 0, 0);
   r0.translateShape(tx, ty);
   g.add(r0);
   BezRectangle r1 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
   r1.setNoStroke();
   r1.setFillColor(alphaForeColor1);
   r1.scaleShape(scaleXY, 0, 0);
   r1.translateShape(tx, ty);
   g.add(r1);
   if (coords.length == 12) {
     BezRectangle r2 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
     r2.setNoStroke();
     r2.setFillColor(alphaForeColor1);
     r2.scaleShape(scaleXY, 0, 0);
     r2.translateShape(tx, ty);
     g.add(r2);
   }
   return g;
 }
 
 
  public GroupComponent loadChar(IntList bal, float scaleXY, float tx, float ty, color bg, color fg) {
   int[] coords = bal.array();
   int i = 0;
   GroupComponent g = new GroupComponent();
   BezRectangle r0 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
   r0.setNoStroke();
   r0.setFillColor(bg);
   r0.scaleShape(scaleXY, 0, 0);
   r0.translateShape(tx, ty);
   g.add(r0);
   BezRectangle r1 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
   r1.setNoStroke();
   r1.setFillColor(fg);
   r1.scaleShape(scaleXY, 0, 0);
   r1.translateShape(tx, ty);
   g.add(r1);
   if (coords.length == 12) {
     BezRectangle r2 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
     r2.setNoStroke();
     r2.setFillColor(fg);
     r2.scaleShape(scaleXY, 0, 0);
     r2.translateShape(tx, ty);
     g.add(r2);
   }
   return g;
 }
 
private void saveAI(String aiFileName) {
  document = new DocumentComponent("Boxy Alphabet");
  // get lots of feedback as we save
  document.setVerbose(true);
  document.setCreator("Ignotus");
  document.setOrg("paulhertz.net");
  document.setWidth(width);
  document.setHeight(height);
  Palette pal = document.getPalette();
  pal.addBlackWhiteGray();
  // now add some layers and give them some geometry 
  // make all the geometry visible in the file
  LayerComponent alphaLayer = new LayerComponent("Alphabet");
  boolean alphaIsVisible = alphaGroup.isVisible();
  if (alphaIsVisible) {
    alphaLayer.add(alphaGroup);
  }
  else {
    alphaGroup.show();
    alphaLayer.add(alphaGroup);
  }
  document.add(alphaLayer);
  LayerComponent messageLayer = new LayerComponent("Message");
  boolean messageIsVisible = messageGroup.isVisible();
  if (messageIsVisible) {
    messageLayer.add(messageGroup);
  }
  else {
    messageGroup.show();
    messageLayer.add(messageGroup);
  }
  document.add(messageLayer);
  PrintWriter output = createWriter(aiFileName);
  document.write(output);
  alphaGroup.setVisible(alphaIsVisible);
  messageGroup.setVisible(messageIsVisible);
}
