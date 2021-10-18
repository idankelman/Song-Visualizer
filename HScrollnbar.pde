class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/40;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }

    if(locked&&S!=null)
    {
      //S.stop();
      boolean Played = S.isPlaying();
      float frame = map(spos,xpos,xpos+swidth,0,S.duration());
      S.amp(0);
      S.jump(frame);
      if(!Played)
        S.pause();
        
      //S.play();
    }
    if(!locked&&S!=null)
      S.amp(Amp);

    if (S!=null&&!locked&&S.isPlaying())
      spos=map(S.position(), 0, (float)S.duration(), (float)xpos, (float)xpos+swidth);
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    this.update();

    rectMode(CORNER);

    noStroke();
    fill(ThemeA_2);
    rect(xpos, ypos, swidth, sheight/1.95);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(color(ThemeA_1));
    }
    //shapeMode(CENTER);
    rect(xpos, ypos, spos-swidth/6, sheight/1.95);
    circle(spos, ypos+sheight/2.75, sheight*2);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
