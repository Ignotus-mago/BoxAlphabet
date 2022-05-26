/**
 * Loads the boxList HashMap with keys and values.
 * Keys are uppercase letters of the alphabet, values are coordinates of rectangles
 * that create the letterforms, in (top, left, width, height) format. The first four
 * coordinates belong to the background rectangle. The next 4 or 8 coordinates
 * belong to foreground rectangles. The characters consist of just 2 or 3 rectangles. 
 *
 */
public void initBoxAlpha() {
  boxList = new HashMap<String, IntList>();
  boxList.put("A", new IntList(0, 0, 7, 7, 0, 1, 6, 2, 0, 4, 6, 3));
  boxList.put("B", new IntList(0, 0, 7, 7, 0, 1, 6, 2, 0, 4, 6, 2));
  boxList.put("C", new IntList(0, 0, 7, 7, 1, 1, 6, 5));
  boxList.put("D", new IntList(0, 0, 7, 7, 0, 1, 6, 5));
  boxList.put("E", new IntList(0, 0, 7, 7, 1, 1, 6, 2, 1, 4, 6, 2));
  boxList.put("F", new IntList(0, 0, 7, 7, 1, 1, 6, 2, 1, 4, 6, 3));
  boxList.put("G", new IntList(0, 0, 7, 7, 1, 1, 6, 3, 0, 5, 6, 2));
  boxList.put("H", new IntList(0, 0, 7, 7, 1, 0, 5, 3, 1, 4, 5, 3));
  boxList.put("I", new IntList(0, 0, 7, 7, 0, 1, 3, 5, 4, 1, 3, 5));
  boxList.put("J", new IntList(0, 0, 7, 7, 0, 0, 6, 6));
  boxList.put("K", new IntList(0, 0, 7, 7, 1, 1, 6, 2, 1, 4, 5, 3));
  boxList.put("L", new IntList(0, 0, 7, 7, 1, 0, 6, 6));
  boxList.put("M", new IntList(0, 0, 7, 7, 1, 1, 2, 6, 4, 1, 2, 6));
  boxList.put("N", new IntList(0, 0, 7, 7, 1, 1, 2, 6, 4, 0, 2, 6));
  boxList.put("O", new IntList(0, 0, 7, 7, 1, 1, 5, 6));
  boxList.put("P", new IntList(0, 0, 7, 7, 0, 1, 6, 2, 1, 4, 6, 3));
  boxList.put("Q", new IntList(0, 0, 7, 7, 0, 1, 5, 5, 6, 0, 1, 6));
  boxList.put("R", new IntList(0, 0, 7, 7, 0, 1, 6, 2, 1, 4, 5, 3));
  boxList.put("S", new IntList(0, 0, 7, 7, 1, 1, 6, 2, 0, 4, 6, 2));
  boxList.put("T", new IntList(0, 0, 7, 7, 0, 1, 3, 6, 4, 1, 3, 6));
  boxList.put("U", new IntList(0, 0, 7, 7, 1, 0, 5, 6));
  boxList.put("V", new IntList(0, 0, 7, 7, 0, 1, 1, 6, 2, 0, 4, 6));
  boxList.put("W", new IntList(0, 0, 7, 7, 1, 0, 2, 6, 4, 0, 2, 6));
  boxList.put("X", new IntList(0, 0, 7, 7, 1, 0, 6, 3, 0, 4, 6, 3));
  boxList.put("Y", new IntList(0, 0, 7, 7, 1, 0, 5, 3, 0, 4, 6, 2));
  boxList.put("Z", new IntList(0, 0, 7, 7, 0, 1, 3, 6, 4, 0, 3, 6));
  boxList.put(" ", new IntList(0, 0, 7, 7, 0, 0, 7, 7));
}


/** 
 * Generates geometry for an individual letterform in our graphical alphabet.
 *
 * @param letter    an IntList of coordinate values (see initBoxAlpha())
 * @param scaleXY   scaling factor for geometry
 * @param tx        x-axis translation, pixels
 * @param ty        y-axis translation, pixels
 *
 * @return          geometry of a single letterform wrapped in a GroupComponent
 */
public GroupComponent loadChar(IntList letter, float scaleXY, float tx, float ty) {
  int[] coords = letter.array();
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


/** 
 * Generates geometry for an individual letterform in our graphical alphabet using supplied colors.
 *
 * @param letter    an IntList of coordinate values (@see initBoxAlpha())
 * @param scaleXY   scaling factor for geometry
 * @param tx        x-axis translation, pixels
 * @param ty        y-axis translation, pixels
 * @param bg        background color
 * @param fg        foreground color
 *
 * @return          geometry of a single letterform wrapped in a GroupComponent
 */
public GroupComponent loadChar(IntList letter, float scaleXY, float tx, float ty, color bg, color fg) {
  int[] coords = letter.array();
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
