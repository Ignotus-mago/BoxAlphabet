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
  boxList.put("X", new IntList(0, 0, 7, 7, 0, 0, 3, 6, 4, 1, 3, 6));
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


//use an enum as a class with initializers to associate properties with each enum token
//We can't use numbers as enum tokens, so here "P" is our old "4" and "S" is the old "5"
public enum Glyph {
  T(3, 2, 4), Z(3, 2, 4), M(5, 2, 4), F(2, 4, 8), Y(3, 4, 8), P(2, 4, 8), Q(3, 3, 8), S(2, 5, 4), H(3, 3, 2);

  private final float minWidth;
  private final float minHeight;
  private final int sym;

  private Glyph(float minWidth, float minHeight, int sym) {
    this.minWidth = minWidth;
    this.minHeight = minHeight;
    this.sym = sym;
  }

  public float minWidth() {
    return this.minWidth;
  }

  public float minHeight() {
    return this.minHeight;
  }

  public int sym() {
    return sym;
  }

  public int zsign() {
    float a = this.minWidth - this.minHeight;
    return ((a) < 0) ? -1 : (a) > 0 ? 1 : 0;
  }
}

public enum GlyphStyle {
  FRAME, LETTER, BRUSH
}

//may be convenient to use classes to reduce calculation, but for now, a quick method will do

//generate our original set of glyphs, source of the alphabet
class GlyphGenerator {
  HashMap<Glyph, GlyphShape> glyphList;
  HashMap<String, IntList> alphaList = new HashMap<String, IntList>();
  float lx;
  float ty;
  float u;
  float w;
  float h;
  float lu;
  float lm;
  float rm;
  float ru;
  float tu;
  float tm;
  float bm;
  float bu;
  float rx;
  float by;
  float xctr;
  float yctr;

  public GlyphGenerator(float x, float y, float w, float h, float u) {
    this.lx = x;
    this.ty = y;
    this.w = w;
    this.h = h;
    this.u = u;
    calculatePoints();
    generateGlyphs();
  }

  public void calculatePoints() {
    this.lu = lx + u;
    this.lm = lx + (w - u) / 2;
    this.rm = lx + (w + u) / 2;
    this.ru = lx + w - u;
    this.tu = ty + u;
    this.tm = ty + (h - u) / 2;
    this.bm = ty + (h + u) / 2;
    this.bu = ty + h - u;
    this.rx = lx + w;
    this.by = ty + h;
    this.xctr = lx + w / 2;
    this.yctr = ty + h / 2;
  }

//Changing any of these values should be followed by a call to calculatePoints and generateGlyphs. 
  public void setLx(float newLx) {
    this.lx = newLx;
  }

  public void setTy(float newTy) {
    this.ty = newTy;
  }

  public void setW(float newW) {
    this.w = newW;
  }

  public void setH(float newH) {
    this.h = newH;
  }

  public void setU(float newU) {
    this.u = newU;
  }

  private void generateGlyphs() {
    this.glyphList = new HashMap<Glyph, GlyphShape>();
    glyphList.put(Glyph.T, makeGlyphShape(Glyph.T, new IntList(lx, ty, rx, by, lx, tu, rm, by, rm, tu, rx, by)));
    glyphList.put(Glyph.Z, makeGlyphShape(Glyph.Z, new IntList(lx, ty, rx, by, lx, tu, rm, by, rm, ty, rx, bu)));
    glyphList.put(Glyph.M, makeGlyphShape(Glyph.M, new IntList(lx, ty, rx, by, lu, tu, lm, by, rm, tu, ru, by)));
    glyphList.put(Glyph.F, makeGlyphShape(Glyph.F, new IntList(lx, ty, rx, by, lu, tu, rx, tm, lu, bm, rx, by)));
    glyphList.put(Glyph.Y, makeGlyphShape(Glyph.Y, new IntList(lx, ty, rx, by, lu, ty, ru, tm, lx, bm, ru, bu)));  
    glyphList.put(Glyph.P, makeGlyphShape(Glyph.P, new IntList(lx, ty, rx, by, lx, tu, ru, tm, lu, bm, rx, by)));
    glyphList.put(Glyph.Q, makeGlyphShape(Glyph.Q, new IntList(lx, ty, rx, by, lx, tu, lm, bu, rm, ty, rx, bu)));
    glyphList.put(Glyph.S, makeGlyphShape(Glyph.S, new IntList(lx, ty, rx, by, lu, tu, rx, tm, lx, bm, ru, bu)));
    glyphList.put(Glyph.H, makeGlyphShape(Glyph.H, new IntList(lx, ty, rx, by, lu, ty, ru, tm, lu, bm, ru, by)));
  }

  public GlyphShape getGlyph(Glyph glyph, int rotFlip) {
    GlyphShape gs;
    if (glyphList.containsKey(glyph)) {
      gs = glyphList.get(glyph);
      return gs;
    }
    // we don't yet have a key entry
    switch (glyph) {
    case T:
      gs = makeGlyphShape(Glyph.T, new IntList(lx, ty, rx, by, lx, tu, rm, by, rm, tu, rx, by));
      glyphList.put(Glyph.T, gs);
      break;
    case Z:
      gs = makeGlyphShape(Glyph.Z, new IntList(lx, ty, rx, by, lx, tu, rm, by, rm, ty, rx, bu));
      glyphList.put(Glyph.Z, gs);
      break;
    case M:
      gs = makeGlyphShape(Glyph.M, new IntList(lx, ty, rx, by, lu, tu, lm, by, rm, tu, ru, by));
      glyphList.put(Glyph.M, gs);
      break;
    case F:
      gs = makeGlyphShape(Glyph.F, new IntList(lx, ty, rx, by, lu, tu, rx, tm, lu, bm, rx, by));
      glyphList.put(Glyph.G, gs);
      break;
    case Y:
      gs = makeGlyphShape(Glyph.Y, new IntList(lx, ty, rx, by, lu, ty, ru, tm, lx, bm, ru, bu));
      glyphList.put(Glyph.Y, gs);
      break;
    case P:
      gs = makeGlyphShape(Glyph.P, new IntList(lx, ty, rx, by, lx, tu, ru, tm, lu, bm, rx, by));
      glyphList.put(Glyph.P, gs);
      break;
    case Q:
      gs = makeGlyphShape(Glyph.Q, new IntList(lx, ty, rx, by, lx, tu, lm, bu, rm, ty, rx, bu));
      glyphList.put(Glyph.Q, gs);
      break;
    case S:
      gs = makeGlyphShape(Glyph.S, new IntList(lx, ty, rx, by, lu, tu, rx, tm, lx, bm, ru, bu));
      glyphList.put(Glyph.S, gs);
      break;
    case H:
      gs = makeGlyphShape(Glyph.H, new IntList(lx, ty, rx, by, lu, ty, ru, tm, lu, bm, ru, by));
      glyphList.put(Glyph.H, gs);
      break;
    default:
      gs = makeGlyphShape(Glyph.T, new IntList(lx, ty, rx, by, lx, tu, rm, by, rm, tu, rx, by));
      glyphList.put(Glyph.T, gs);
      break;
    }
    return gs;
  }

  public GlyphShape makeGlyphShape(Glyph glyph, IntList coords) {
    int i = 0;
    return new GlyphShape(glyph,
        BezRectangle.makeLeftTopRightBottom(coords.get(i++), coords.get(i++), coords.get(i++), coords.get(i++)),
        BezRectangle.makeLeftTopRightBottom(coords.get(i++), coords.get(i++), coords.get(i++), coords.get(i++)),
        BezRectangle.makeLeftTopRightBottom(coords.get(i++), coords.get(i++), coords.get(i++),
            coords.get(i++)));
  }

}

public class GlyphShape {
  Glyph glyph;
  GroupComponent g;
  BezRectangle r0;
  BezRectangle r1;
  BezRectangle r2;

  /**
  *
  */
  public GlyphShape(Glyph glyph, BezRectangle r0, BezRectangle r1, BezRectangle r2) {
    this.glyph = glyph;
    this.r0 = r0;
    this.r1 = r1;
    this.r2 = r2;
    this.g = new GroupComponent();
    g.add(r0);
    g.add(r1);
    g.add(r2);
  }

  public GroupComponent getGroup() {
    return this.g;
  }

  public BezRectangle r0() {
    return this.r0;
  }

  public BezRectangle r1() {
    return this.r1;
  }

  public BezRectangle r2() {
    return this.r2;
  }

  public void setColors(color c0, color c1, color c2) {
    r0.setFillColor(c0);
    r1.setFillColor(c1);
    r2.setFillColor(c2);
  }

  public void setGlyphBackColor(color c) {
    r0.setFillColor(c);
  }

  public void setGlyphForeColor(color c) {
    r1.setFillColor(c);
    r2.setFillColor(c);
  }
  
  public void setNoStroke() {
    r0.setNoStroke();
    r1.setNoStroke();
    r2.setNoStroke();
  }
  
  public void draw() {
    this.g.draw();
  }

  /**
   * Generates geometry for an individual letterform in our graphical alphabet
   * using supplied colors.
   *
   * @param letter  an IntList of coordinate values (@see initBoxAlpha())
   * @param scaleXY scaling factor for geometry
   * @param tx      x-axis translation, pixels
   * @param ty      y-axis translation, pixels
   * @param bg      background color
   * @param fg      foreground color
   *
   */
  public void loadChar(IntList letter, float scaleXY, float tx, float ty, color bg, color fg) {
    int[] coords = letter.array();
    int i = 0;
    g = new GroupComponent();
    r0 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
    r0.setNoStroke();
    r0.setFillColor(bg);
    r0.scaleShape(scaleXY, 0, 0);
    r0.translateShape(tx, ty);
    g.add(r0);
    r1 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
    r1.setNoStroke();
    r1.setFillColor(fg);
    r1.scaleShape(scaleXY, 0, 0);
    r1.translateShape(tx, ty);
    g.add(r1);
    if (coords.length == 12) {
      r2 = BezRectangle.makeLeftTopWidthHeight(coords[i++], coords[i++], coords[i++], coords[i++]);
      r2.setNoStroke();
      r2.setFillColor(fg);
      r2.scaleShape(scaleXY, 0, 0);
      r2.translateShape(tx, ty);
      g.add(r2);
    }
  }
}

