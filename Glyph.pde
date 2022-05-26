// Let's use an enum as a class with initializers to associate properties with each enum token.
// We can't use numbers as enum tokens, so here "P" is our old "4" and "S" is the old "5".
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

  // zsign is -1 for vertical rectangles, 0 for squares, and 1 for horizontal rectangles
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

  // Changing any of the initial values should be followed by a call to calculatePoints
  public void regenerate(float x, float y, float w, float h, float u) {
    this.lx = x;
    this.ty = y;
    this.w = w;
    this.h = h;
    this.u = u;
    calculatePoints();
  }
  

  public GlyphShape getGlyph(Glyph glyph, boolean rot90) {
    GlyphShape gs;
    switch (glyph) {
    case T:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.T, new IntList(lx, ty, rx, by, lx, tu, lm, by, rm, tu, rx, by));
      }
      else {
        gs = makeGlyphShape(Glyph.T, new IntList(lx, ty, rx, by, lx, ty, ru, tm, lx, bm, ru, by));
      }
      break;
    case Z:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.Z, new IntList(lx, ty, rx, by, lx, tu, lm, by, rm, ty, rx, bu));
      }
      else {
        gs = makeGlyphShape(Glyph.Z, new IntList(lx, ty, rx, by, lx, ty, ru, tm, lu, bm, rx, by));
      }
      break;
    case M:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.M, new IntList(lx, ty, rx, by, lu, tu, lm, by, rm, tu, ru, by));
      }
      else {
        gs = makeGlyphShape(Glyph.M, new IntList(lx, ty, rx, by, lx, tu, ru, tm, lx, bm, ru, bu));        
      }
      break;
    case F:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.F, new IntList(lx, ty, rx, by, lu, tu, rx, tm, lu, bm, rx, by));
      }
      else {
        gs = makeGlyphShape(Glyph.F, new IntList(lx, ty, rx, by, rm, tu, ru, by, lx, tu, lm, by));
      }
      break;
    case Y:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.Y, new IntList(lx, ty, rx, by, lu, ty, ru, tm, lx, bm, ru, bu));
      }
      else {
        gs = makeGlyphShape(Glyph.Y, new IntList(lx, ty, rx, by, rm, tu, rx, bu, lu, ty, lm, bu));
      }
      break;
    case P:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.P, new IntList(lx, ty, rx, by, lx, tu, ru, tm, lu, bm, rx, by));
      }
      else {
        gs = makeGlyphShape(Glyph.P, new IntList(lx, ty, rx, by, rm, ty, ru, bu, lx, tu, lm, by));
      }
      break;
    case Q:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.Q, new IntList(lx, ty, rx, by, lx, tu, lm, bu, rm, ty, rx, bu));
      }
      else {
        gs = makeGlyphShape(Glyph.Q, new IntList(lx, ty, rx, by, lu, ty, ru, tm, lu, bm, rx, by));
      }
      break;
    case S:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.S, new IntList(lx, ty, rx, by, lu, tu, rx, tm, lx, bm, ru, bu));
      }
      else {
        gs = makeGlyphShape(Glyph.S, new IntList(lx, ty, rx, by, rm, tu, ru, by, lu, ty, lm, bu));
      }
      break;
    case H:
      if (!rot90) {
        gs = makeGlyphShape(Glyph.H, new IntList(lx, ty, rx, by, lu, ty, ru, tm, lu, bm, ru, by));
      }
      else {
        gs = makeGlyphShape(Glyph.H, new IntList(lx, ty, rx, by, rm, tu, rx, bu, lx, tu, lm, bu));
      }
      break;
    default:
      gs = makeGlyphShape(Glyph.T, new IntList(lx, ty, rx, by, lx, tu, rm, by, rm, tu, rx, by));
      break;
    }
    return gs;
  }

  public GlyphShape makeGlyphShape(Glyph glyph, IntList coords) {
    GlyphShape gs = new GlyphShape(glyph, coords);
    return gs;
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
    if (null != r1) this.r1 = r1;
    if (null != r2) this.r2 = r2;
    this.g = new GroupComponent();
    g.add(r0);
    if (null != r1) g.add(r1);
    if (null != r2) g.add(r2);
  }
  
  public GlyphShape(Glyph glyph, IntList coords) {
    this.glyph = glyph;
    this.g = new GroupComponent();
    int i = 0;
    r0 = BezRectangle.makeLeftTopRightBottom(coords.get(i++), coords.get(i++), coords.get(i++), coords.get(i++));
    g.add(r0);
    if (coords.size() >= 8) {
      r1 = BezRectangle.makeLeftTopRightBottom(coords.get(i++), coords.get(i++), coords.get(i++), coords.get(i++));
      g.add(r1);
    }
    if (coords.size() == 12) {
      r2 = BezRectangle.makeLeftTopRightBottom(coords.get(i++), coords.get(i++), coords.get(i++), coords.get(i++));
      g.add(r2);
    }
  }

  public GroupComponent getGroup() {
    return this.g;
  }
  
  public Glyph getGlyph() {
    return this.glyph;
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

  public GlyphShape setFillColors(color c0, color c1, color c2) {
    r0.setFillColor(c0);
    if (null != r1) r1.setFillColor(c1);
    if (null != r2) r2.setFillColor(c2);
    return this;
  }

  public void setGlyphBackColor(color c) {
    r0.setFillColor(c);
  }

  public void setGlyphForeColor(color c) {
    if (null != r1) r1.setFillColor(c);
    if (null != r2) r2.setFillColor(c);
  }
  
  public GlyphShape setNoStroke() {
    r0.setNoStroke();
    if (null != r1) r1.setNoStroke();
    if (null != r2) r2.setNoStroke();
    return this;
  }
  
  public void draw() {
    this.g.draw();
  }
  
  public void transform(Matrix3 m) {
    this.g.transform(m);
  }
  
  public void rotateGlyph(float ang) {
    float xctr = r0.getCenterPoint().x();
    float yctr = r0.getCenterPoint().y();
    Matrix3 m = new Matrix3();
    m.translateCTM(-xctr, -yctr);
    m.rotateCTM(ang);
    m.translateCTM(xctr, yctr);
    g.transform(m);
  }

  
  public void rotate180() {
    float xctr = r0.getCenterPoint().x();
    float yctr = r0.getCenterPoint().y();
    Matrix3 m = new Matrix3();
    m.translateCTM(-xctr, -yctr);
    m.rotateCTM(PI);
    m.translateCTM(xctr, yctr);
    g.transform(m);
  }
  
  public void flipH() {
    float xctr = r0.getCenterPoint().x();
    float yctr = r0.getCenterPoint().y();
    Matrix3 m = new Matrix3();
    m.translateCTM(-xctr, -yctr);
    m.reflectCTM(true);
    m.translateCTM(xctr, yctr);
    g.transform(m);
  }
  
  public void flipV() {
    float xctr = r0.getCenterPoint().x();
    float yctr = r0.getCenterPoint().y();
    Matrix3 m = new Matrix3();
    m.translateCTM(-xctr, -yctr);
    m.reflectCTM(false);
    m.translateCTM(xctr, yctr);
    g.transform(m);
  }
  
  public void translate(float tx, float ty) {
    Matrix3 m = new Matrix3();
    m.translateCTM(tx, ty);
    g.transform(m);
  }
  
  public GlyphShape clone() {
    BezRectangle newR0 = BezRectangle.makeRectangle(this.r0);
    BezRectangle newR1 = null;
    BezRectangle newR2 = null;
    if (null != r1) newR1 = BezRectangle.makeRectangle(this.r1);
    if (null != r2) newR2 = BezRectangle.makeRectangle(this.r2);
    return new GlyphShape(this.glyph, newR0, newR1, newR2);    
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
  /*   
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
  */
  
}