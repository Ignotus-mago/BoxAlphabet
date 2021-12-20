/**
 * BoxAlphabet
 * @author Paul Hertz
 * https://paulhertz.net/
 *
 * Generates and displays a 26-character graphic alphabet using a 7x7 grid. 
 * All characters consist of at most two rectangles superimposed on a background square.
 * Generates and displays a text created from these letterforms. 
 * Press spacebar to swap display between alphabet and text.
 * Press "s" to save to an Adobe Illustrator 7.0 file (you can sitll open this old, text-based format in AI).
 * Press "p"to save to a PDF file. 
 *
 * The IgnoCodeLib contributed library provides all sorts of hooks for creating shapes and organizing them
 * in a hierarchical tree structure of groups and layers. It also simplifies drawing and saving. Every display
 * element in the library has a draw() command. For AI files, there's also a write() command. Both commands 
 * cascade down the tree when called on a document, layer, or group object. This can make drawing pretty simple.
 * Shapes, groups and layers can also be hidden or shown. 
 *
 * Since this software involves the sort of content that sometimes is subject to legal battles, namely, a font, 
 * I am releasing it under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 Internation license, 
 * (CC BY-NC-SA 4.0, https://creativecommons.org/licenses/by-nc-sa/4.0/). 
 * 
 * This software is free for non-commercial use, please share any mods with the same license. I would also really 
 * appreciate it if you notify me if you use it in artworks or other public contexts.
 *
 */

import net.paulhertz.aifile.*;
import net.paulhertz.geom.*;
import net.paulhertz.util.*;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Iterator;

import processing.pdf.*;

HashMap<String, IntList> boxList;
color backgroundColor = color(254, 246, 233);
color alphaBackColor1;
color alphaBackColor2;
color alphaForeColor1;
color alphaForeColor2;
color spaceColor1;
color spaceColor2;
String msg;
int sxy = 8;
float border = 16;
int d = 64;
boolean testing = false;

IgnoCodeLib igno;

// random utilities
RandUtil rand;


/** objects that organize our geometry */
GroupComponent messageGroup;
GroupComponent alphaGroup;
GroupComponent glyphGroup;
DocumentComponent document;


public void setup() {
  size(1024, 1024);
  igno = new IgnoCodeLib(this);
  rand = new RandUtil();
  initBoxAlpha();
  setupGeometry();
  glyphGroup = new GroupComponent();
  border = 16;
  loadGlyphGroup();
  showHelp();
}


/** 
 * Sets colors and loads geometry into the alphaGroup and messageGroup. 
 */
public void setupGeometry() {
  backgroundColor = color(123, 110, 144);
  alphaBackColor1 = color(21, 34, 55);
  alphaBackColor2 = color(89, 110, 233);
  alphaForeColor1 = color(233, 233, 47);
  alphaForeColor2 = color(199, 34, 42);
  alphaGroup = loadAlphabet();
  alphaGroup.hide();
  alphaBackColor1 = color(254, 251, 246);
  alphaBackColor2 = color(254, 246, 233);
  alphaBackColor2 = alphaBackColor1;
  alphaForeColor1 = color(8, 13, 21);
  alphaForeColor2 = color(246, 233, 241);
  //alphaForeColor1 = alphaForeColor2;
  float brighter = 1.75;
  spaceColor1 = color(123, 110, 144);
  spaceColor2 = spaceColor1;
  //spaceColor1 = backgroundColor;
  //spaceColor2 = backgroundColor;
  /*
  msg = "Oblivion is not to be hired: The greater part must be content to be as though they had not been, " 
   + "to be found in the Register of God, not in the record of man. Twenty seven Names make up the first story, " 
   + "and the recorded names ever since contain not one living Century. The number of the dead long exceedeth " 
   + "all that shall live. The night of time far surpasseth the day, and who knows when was the Equinox? " 
   + "Every houre addes unto that current Arithmetique, which scarce stands one moment. And since death must be the " 
   + "Lucina of life, and even Pagans could doubt whether thus to live, were to dye. Since our longest " 
   + "Sunne sets at right descensions, and makes but winter arches, and therefore it cannot be long before " 
   + "we lie down in darknesse, and have our lights in ashes. Since the brother of death daily haunts us " 
   + "with dying mementos, and time that grows old it self, bids us hope no long duration: Diuturnity is " 
   + "a dream and folly of expectation.";
   */

  msg = "This Reticulate or Net-work was also considerable in the inward parts of man, not only from the first subtegmen "
    + "or warp of his formation, but in the netty fibres of the veins and vessels of life; wherein according to common "
    + "Anatomy the right and transverse fibres are decussated, by the oblique fibres; and so must frame a Reticulate and "
    + "Quincunciall Figure by their Obliquations, Emphatically extending that Elegant expression of Scripture, Thou hast "
    + "curiously embroydered me, thou hast wrought me up after the finest way of texture, and as it were with a Needle";
  /*
  msg = "Light that makes things seen, makes some things invisible, were it not for darknesse and the shadow of the earth, "
   + "the noblest part of the Creation had remained unseen, and the Stars in heaven as invisible as on the fourth day, "
   + "when they were created above the Horizon, with the Sun, or there was not an eye to behold them.";
   msg = " Five miles meandering with a mazy motion Through wood and dale the sacred river ran, Then reached the caverns measureless to man, "
   + "And sank in tumult to a lifeless ocean; And ’mid this tumult Kubla heard from far Ancestral voices prophesying war!";
   */
  // msg = "Happy Birthday";
  msg = "APLACEWHEREWECANWEEP";
  println("\nMessage:\n"+ msg +"\n");
  messageGroup = loadMessageJustified(msg);
}

public void loadGlyphGroup() {
    glyphGroup.children().clear();
    glyphGroup.add(glyphTestThree(32, 32, 480, 480, border));
    glyphGroup.add(glyphTestThree(32 + 480, 32, 480, 480, border));
    glyphGroup.add(glyphTestThree(32 + 480, 32 + 480, 480, 480, border));
    glyphGroup.add(glyphTestThree(32, 32 + 480, 480, 480, border));
}


public void showHelp() {
  println("----->>> Press spacebar to swap display.              <<<-----");
  println("----->>> Press 's' to save to Adobe Illustrator file. <<<-----");
  println("----->>> Press 'p' to save to PDF file.               <<<-----");
}


public void draw() {
  background(255);
  //alphaGroup.hide();
  //messageGroup.hide();
  alphaGroup.draw();
  messageGroup.draw();
  //glyphGroup.draw();
}


public void keyPressed() {
  if (key == ' ') {
    if (alphaGroup.isVisible()) {
      alphaGroup.hide();
      messageGroup.show();
    } else {
      alphaGroup.show();
      messageGroup.hide();
    }
  } else if (key == 's' || key == 'S') {
    println("----->>> SAVING AI");
    saveAI("message+alphabet.ai");
  } else if (key == 'g' || key == 'G') {
    println("----->>> SAVING GLYPHS AI");
    saveGlyphsAI("glyphs.ai");
  } else if (key == 'w' || key == 'W') {
    loadGlyphGroup();
  } else if (key == 'p' || key == 'P') {
    println("----->>> SAVING PDF");
    savePDF("message+alphabet.pdf");
  } else if (key == 'j' || key == 'J') {
    messageGroup = loadMessageJustified(msg);
  }
}


/** 
 * Generates geometry for the alphabet defined in the boxList HashMap and 
 * returns it in a GroupComponent. 
 *
 * @return   a GroupComponent with a subgroup for each letter in the alphabet.
 */
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
  GroupComponent alphaGroup = new GroupComponent();
  for (IntList letter : boxList.values()) {
    GroupComponent g = loadChar(letter, scaleXY, tx, ty);
    alphaGroup.add(g);
    tx += xinc;
    i++;
    if (i >= rowCount) {
      i = 0;
      ty += yinc;
      tx = startX;
    }
  }
  return alphaGroup;
}


/** 
 * Generates geometry for a graphical representation of the supplied String and
 * returns it wrapped in a GroupComponent. 
 *
 * @param  mess   the String to be encoded as geometry
 * @return geometry wrapped in a GroupComponent     
 */
public GroupComponent loadMessage(String mess) {
  int[] colorValues = {233, 212, 220, 89, 76, 68};
  String[] words = mess.toUpperCase().split(" ");
  float startX = 32;
  float startY = 32;
  float scaleXY = sxy * 0.825;
  float tx = startX;
  float xinc = scaleXY * 6;
  float ty = startY;
  float yinc = scaleXY * 6;
  int breakWord = 12;
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
        IntList letter = boxList.get(ch);
        // alternate colors
        color c1 = charCount % 2 == 0 ? alphaBackColor1 : alphaBackColor2;
        color c2 = charCount % 2 == 0 ? alphaForeColor1 : alphaForeColor2;
        charCount++;
        g = loadChar(letter, scaleXY, tx, ty, c2, c1);
        messGroup.add(g);
        tx += xinc;
      }
      // we reached the end of a word
      IntList letter = boxList.get(" ");
      // alternate colors
      color c1 = charCount % 2 == 0 ? spaceColor1 : spaceColor2;
      //color c1 = Palette.randColor(colorValues);
      color c2 = charCount % 2 == 0 ? alphaBackColor1 : alphaBackColor2;
      charCount++;
      g = loadChar(letter, scaleXY, tx, ty, c2, c1);
      tx += xinc;
      // breakword is used to set a somewhat arbitrary limit on line length
      if (tx > width - breakWord * xinc) {
        // start a new line of text
        tx = startX;
        ty += yinc;
        charCount = 0;
        // swap the colors to keep up the checkerboard pattern
        int temp = alphaBackColor1;
        alphaBackColor1 = alphaBackColor2;
        alphaBackColor2 = temp;
        temp = alphaForeColor1;
        alphaForeColor1 = alphaForeColor2;
        alphaForeColor2 = temp;
        temp = spaceColor1;
        spaceColor1 = spaceColor2;
        spaceColor2 = temp;
      } else {
        messGroup.add(g);
      }
    }
  }
  return messGroup;
}


/** 
 * Generates geometry for a graphical representation of the supplied String and
 * returns it wrapped in a GroupComponent. 
 *
 * This version of the method uses the same number of characters in each line.
 *
 * @param  mess   the String to be encoded as geometry
 * @return geometry wrapped in a GroupComponent     
 */
public GroupComponent loadMessageJustified(String mess) {
  int[] mid = {110, 123, 144, 157, 165, 178};
  int[] light = {178, 186, 199, 220, 233};
  int[] colorValues = {21, 34, 47, 55, 76, 89, 178, 186, 199, 220, 233};
  String[] words = mess.toUpperCase().split(" ");
  float startX = 32;
  float startY = 32;
  float scaleXY = sxy * 3;
  float tx = startX;
  float xinc = scaleXY * 7.25;
  float ty = startY;
  float yinc = scaleXY * 7.25;
  // letters per line
  int breakWord = 5;
  int charCount = 0;
  GroupComponent g;
  GroupComponent messGroup = new GroupComponent();
  Pattern pattern = Pattern.compile("[A-Z]+");
  StringBuffer buf = new StringBuffer(mess.length()); 
  for (int i = 0; i < words.length; i++) {
    String src = words[i];
    Matcher matcher = pattern.matcher(src);
    if (matcher.find()) {
      String word = matcher.group();
      if (testing) println(word);
      buf.append(word + " ");
    }
  }
  color c1, c2, cNext;
  cNext = Palette.randColor(colorValues);
  c1 = cNext;
  for (int i = 0; i < buf.length(); i++) {
    IntList letter = boxList.get(str(buf.charAt(i)));
    // alternate colors
    c2 = i % 2 == 0 ? alphaForeColor1 : alphaForeColor2;
    if (' ' == buf.charAt(i)) {
      c1 = spaceColor2;
    } else {
      c1 = i % 2 == 0 ? Palette.randColor(light) : Palette.randColor(mid);
      //c1 = cNext;
      //cNext = Palette.randColor(colorValues);
    }
    charCount++;
    g = loadChar(letter, scaleXY, tx, ty, c2, c1);
    messGroup.add(g);
    tx += xinc;
    if (charCount % breakWord == 0) {
      // start a new line of text
      tx = startX;
      ty += yinc;
      // swap colors for checkerboard pattern
      int temp = alphaBackColor1;
      alphaBackColor1 = alphaBackColor2;
      alphaBackColor2 = temp;
      temp = alphaForeColor1;
      alphaForeColor1 = alphaForeColor2;
      alphaForeColor2 = temp;
      temp = spaceColor1;
      spaceColor1 = spaceColor2;
      spaceColor2 = temp;
      // cNext = Palette.randColor(colorValues);
      int[] temparr = light;
      mid = light;
      light = temparr;
    }
  }
  return messGroup;
}


// the ordered set of 9 glyphs in 8 rotations and reflections
public GroupComponent glyphTestOne() {
  int c0 = color(13, 21, 34);
  int c1 = color(220, 220, 110);
  int c2 = color(89, 144, 233);
  float x = 32;
  float y = 32;
  float step = 108;
  int i = 0;
  int j = 0;
  boolean r90 = false;
  GroupComponent g = new GroupComponent();
  GlyphGenerator gen = new GlyphGenerator(0, 0, 89, 89, 13);
  GlyphShape gs;
  // step through 90 degree rotations
  for (j = 0; j < 8; j++) {
    i = 0;
    for (Glyph glyph : Glyph.values()) {
      gs = gen.getGlyph(glyph, r90).setNoStroke().setFillColors(c0, c1, c2);
      if (j%4 >= 2) gs.rotate180();
      if (j>=4) gs.flipV();
      gs.translate(step * i + x, step * j + y);
      g.add(gs.getGroup());
      i++;
    }
    r90 = !r90;
  }
  return g;
}


// random ordering of the 9 glyphs, each in 8 rotations and reflections
public GroupComponent glyphTestTwo() {
  int c0 = color(#172536);
  int c1 = color(#E9C759);
  int c2 = color(#7BC7E9);
  int[] mid = {110, 123, 144};
  int[] light = {199, 220, 233};
  float x = 32;
  float y = 32;
  float step = 89;  // 76 for overlap, 97 for separation
  int i = 0;
  int j = 0;
  boolean r90 = false;
  GroupComponent g = new GroupComponent();
  GlyphGenerator gen = new GlyphGenerator(0, 0, 89, 89, 13);
  GlyphShape gs;
  ArrayList<GlyphShape> gsList = new ArrayList<GlyphShape>();
  // step through rotations and reflections, but without translation
  for (j = 0; j < 8; j++) {
    for (Glyph glyph : Glyph.values()) {
      //c1 = Palette.randColor(mid);
      //c2 = Palette.randColor(light);
      gs = gen.getGlyph(glyph, r90).setNoStroke().setFillColors(c0, c1, c2);
      if (j%4 >= 2) gs.rotate180();
      if (j>=4) gs.flipV();
      gsList.add(gs);
    }
    r90 = !r90;
  }
  RandUtil rand = new RandUtil();
  // randomize the order of glyphs
  rand.shuffle((ArrayList)gsList);
  int lim = Glyph.values().length;
  for (j = 0; j < 8; j++) {
    for (i = 0; i < lim; i++) {
      gs = gsList.get(j*lim + i);
      // println("----->>> "+ (j*lim+i) +": "+ gs.r0().getCenterPoint().x() +", "+ gs.r0().getCenterPoint().y() +"     (j = "+ j +", i = "+ i +")");
      gs.translate(step * i + x, step * j + y);
      // println("----->>> "+ (j*lim+i) +": "+ gs.r0().getCenterPoint().x() +", "+ gs.r0().getCenterPoint().y() +"\n");
      g.add(gs.getGroup());
    }
  }
  return g;
}

// recursive patterns
public GroupComponent glyphTestThree(float x, float y, float w, float h, float u) {
  GroupComponent g = new GroupComponent();
  int c0 = color(13, 21, 34);
  int c1 = color(220, 220, 110);
  int c2 = color(110, 220, 233);
  int c3 = color(144, 157, 165);
  int c4 = color(220, 144, 165);
  int[] mid = {110, 123, 144};
  int[] light = {199, 220, 233};
  Glyph glyph;
  Iterator<Glyph> glit = glyphIter();
  glyph = nextGlyph(glit);
  /*
  float x = 32;
  float y = 32;
  float w = width - 6*x;
  float h = height - 2*y;
  // set u to fraction of width or height, whichever is smaller
  float u = w <= h ? w/12 : h/12;
  u = border;
  */
  GlyphGenerator gen = new GlyphGenerator(x, y, w, h, u);
  boolean r90 = GeomUtils.zsgn(w - h) != glyph.zsign();
  GlyphShape gs = gen.getGlyph(glyph, r90);
  gs.setNoStroke();
  gs.setFillColors(c0, c1, c2);
  gs.flipV();
  // here's our problem: top, left, right, bottom are no longer accurate locations
  println("----->>> r0: "+ gs.r0.getLeft(), gs.r0().getTop(), gs.r0().getRight(), gs.r0().getBottom());
  g.add(gs.getGroup());
  //
  boolean isRecursed = false;
  if (isRecursed) {
    ArrayList<GlyphShape> gsList = new ArrayList<GlyphShape>();
    gsList = reGlyphStep(gs, nextGlyph(glit), gen, new ArrayList<GlyphShape>(), 5);
    for (int i = 0; i < gsList.size(); i++ ) {
      g.add(gsList.get(i).getGroup());
      println("----->>> gsList "+ i +": "+ gsList.get(i).getGlyph());
    }
  }
  else {
    c0 = Palette.randColor(mid);
    // solution to our problem is to use the bounds rect, but we should fix the BezRectangle class usage, too 
    BezRectangle r1 = gs.r1().boundsRect();
    BezRectangle r2 = gs.r2().boundsRect();
    gs = glyphStep(r1, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c3, c1, c2);
    g.add(gs.getGroup());
    BezRectangle r3 = gs.r1().boundsRect();
    BezRectangle r4 = gs.r2().boundsRect();
    gs = glyphStep(r3, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c0, c1, c2);
    g.add(gs.getGroup());
    BezRectangle r7 = gs.r1().boundsRect();
    BezRectangle r8 = gs.r2().boundsRect();
    gs = glyphStep(r4, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c0, c1, c2);
    g.add(gs.getGroup());
    BezRectangle r11 = gs.r1().boundsRect();
    BezRectangle r12 = gs.r2().boundsRect();
    gs = glyphStep(r7, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
    gs = glyphStep(r8, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
    gs = glyphStep(r11, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
    gs = glyphStep(r12, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
    //
    gs = glyphStep(r2, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c3, c1, c2);
    g.add(gs.getGroup());
    BezRectangle r5 = gs.r1().boundsRect();
    BezRectangle r6 = gs.r2().boundsRect();
    gs = glyphStep(r5, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c0, c1, c2);
    g.add(gs.getGroup());
    BezRectangle r9 = gs.r1().boundsRect();
    BezRectangle r10 = gs.r2().boundsRect();
    gs = glyphStep(r6, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c0, c1, c2);
    g.add(gs.getGroup());
    BezRectangle r13 = gs.r1().boundsRect();
    BezRectangle r14 = gs.r2().boundsRect();
    gs = glyphStep(r9, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
    gs = glyphStep(r10, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
    gs = glyphStep(r13, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
    gs = glyphStep(r14, nextGlyph(glit), gen);
    gs.setNoStroke();
    gs.setFillColors(c4, c1, c2);
    g.add(gs.getGroup());
  }
  //
  return g;
}

public Iterator<Glyph> glyphIter() {
  ArrayList<Glyph> glyphList = new ArrayList<Glyph>();
  for (Glyph glyph : Glyph.values()) {
    glyphList.add(glyph);
  }
  // randomize the order of glyphs
  rand.shuffle((ArrayList)glyphList);
  return glyphList.iterator();
}

public Glyph nextGlyph(Iterator<Glyph> glit) {
  if (glit.hasNext()) { 
    return glit.next();
  }
  else {
    glit = glyphIter();
    return glit.next();
  }
}

/**/
// non-recursive version
public GlyphShape glyphStep(BezRectangle r, Glyph glyph, GlyphGenerator gen) {
  float x = r.getLeft();
  float y = r.getTop();
  float w = r.getWidth();
  float h = r.getHeight();
  float u = w <= h ? w/5 : h/5;
  u = border;
  gen.regenerate(x, y, w, h, u);
  boolean r90 = GeomUtils.zsgn(w - h) != glyph.zsign();
  GlyphShape gs = gen.getGlyph(glyph, r90);
  if (random(1) > 0.5) gs.rotate180();
  if (random(1) > 0.5) gs.flipV();
  return gs;
}
/**/

/**/
public ArrayList<GlyphShape> reGlyphStep(GlyphShape gs, Glyph glyph, GlyphGenerator gen, ArrayList<GlyphShape> gsList, int depth) {
  if (depth > 0) {
    GlyphShape gs1 = glyphStep(gs.r1().boundsRect(), glyph, gen);
    gsList.add(gs1);
    reGlyphStep(gs1, glyph, gen, gsList, depth - 1);
    GlyphShape gs2 = glyphStep(gs.r2().boundsRect(), glyph, gen);
    reGlyphStep(gs2, glyph, gen, gsList, depth - 1);
  } 
  return gsList;
}
/**/

/**
 * Saves geometry as an Adobe Illustrator 7.0 file, an old text-based PostScript format 
 * that still opens in current version of Illustrator. 
 *
 * The alphabet (alphaGroup) and message (messageGroup) are placed in separate layers. 
 */
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
  alphaGroup.show();
  alphaLayer.add(alphaGroup);
  document.add(alphaLayer);
  LayerComponent messageLayer = new LayerComponent("Message");
  boolean messageIsVisible = messageGroup.isVisible();
  messageGroup.show();
  messageLayer.add(messageGroup);
  document.add(messageLayer);
  PrintWriter output = createWriter(aiFileName);
  document.write(output);
  alphaGroup.setVisible(alphaIsVisible);
  messageGroup.setVisible(messageIsVisible);
}

private void saveGlyphsAI(String aiFileName) {
  document = new DocumentComponent("Boxy Alphabet");
  // get lots of feedback as we save
  document.setVerbose(true);
  document.setCreator("Ignotus");
  document.setOrg("paulhertz.net");
  document.setWidth(width);
  document.setHeight(height);
  Palette pal = document.getPalette();
  pal.addBlackWhiteGray();
  LayerComponent glyphLayer = new LayerComponent("Glyphs");
  glyphLayer.add(glyphGroup);
  document.add(glyphLayer);
  PrintWriter output = createWriter(aiFileName);
  document.write(output);
}

/**
 * Saves geometry to a PDF file. It's pretty simple to do: just call beginRecord(), call draw() 
 * for the top-level element or elements in the display graph, and then call endRecord().
 */
private void savePDF(String pdfFileName) {
  beginRecord(PDF, pdfFileName);
  // make sure everything is visible, otherwise it won't draw.
  boolean alphaIsVisible = alphaGroup.isVisible();
  alphaGroup.show();
  alphaGroup.draw();
  boolean messageIsVisible = messageGroup.isVisible();
  messageGroup.show();
  messageGroup.draw(); 
  // restore visibility settings
  alphaGroup.setVisible(alphaIsVisible);
  messageGroup.setVisible(messageIsVisible);
  endRecord();
}
