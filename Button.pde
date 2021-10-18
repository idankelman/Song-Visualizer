class Button 
{
  //======================================================================================= 
  //*vars
  //=======================================================================================
  public Button Act; //delete or add new 
  PVector Pos;
  PVector Prev;
  PImage Im;
  PImage Switch;
  ArrayList<String> Txt;

  boolean Circ=false;
  boolean Rect=true;
  boolean Sqr=false;
  boolean Marked= false;

  int ID;

  private float Rad;
  private float MinRad;
  private float MaxRad;
  private float Height;
  private boolean Visable=true;
  public boolean Lerp_Rad=true;
  public boolean Lerp_Color=true;
  public boolean Pressed= false;
  public boolean Pressable= true;
  public boolean open = false;
  public boolean ButtonAnim= false;
  private color C;
  public float alpha=0;
  public float minA=40;
  private String S="";
  public String T ="";
  private float Roundness=14;
  public static final  float TextSize=13;
  public boolean fill = true;
  public float lerpSpeed=0.035;
  public boolean Transparent = false;
  public boolean Visualaize= false;



  //*constructor
  //-----------------------------------------------------------------------------------
  public Button(float x, float y, float Rad)
  {
    Pos= new PVector(x, y);
    Prev = new PVector(x, y);
    this.Rad=0;
    this.MinRad=Rad/5;
    this.MaxRad=Rad;
    C=color(255);
    ID=(int)(random(0, 1)*1000);
  }
  //*empty constructor
  //------------------------------------------------------------------------------------

  public Button()
  {

    this.Rad=random(width/15, width/10);
    this.MinRad=Rad/8;
    this.MaxRad=Rad;
    this.Rad=0;
    Pos= new PVector(random(Rad, width-Rad), random(Rad, height-Rad));
    Prev= new PVector(random(Rad, width-Rad), random(Rad, height-Rad));
    C=color(255);
    ID=(int)(random(0, 1)*1000);
  }

  //*function that varies if we need to lerp or not
  //------------------------------------------------------------------------------------

  public void Update()
  {
    if (Lerp_Rad==true)
      this.Rad=Lerp(Rad, MaxRad, lerpSpeed);
    else
      this.Rad=Lerp(Rad, MinRad, lerpSpeed);

    if (Lerp_Color==true)
      this.alpha=Lerp(alpha, 255, lerpSpeed*3);
    else
      this.alpha=Lerp(alpha, minA, lerpSpeed*5);

    this.Pos.x= Lerp(Pos.x, Prev.x, lerpSpeed); 
    this.Pos.y= Lerp(Pos.y, Prev.y, lerpSpeed);
  }

  //*Show functon- draws the shape (circ,sqr,rect), with text S , size Rad , color C
  //------------------------------------------------------------------------------------


  public void Show()
  {
    if (this.Visable==false)
      return;

    if (ButtonAnim==true)
      this.ButtonAnimation();

    Update();



    shapeMode(CENTER);
    rectMode(CENTER);
    fill(C, alpha);
    noStroke();
    if (this.Im!=null&&this.Im==Button_Im)
      alpha=255;
    tint(255, alpha); 




    if (this.fill==false)
    {
      noFill();
      stroke(C, alpha);
      strokeWeight(1.2);
    }

    if (Rect==true)
    {
      if (Height == 0)
      {
        if (Transparent==false)
          rect(Pos.x, Pos.y, Rad*2, Rad/1.5, Roundness);
        if (Im!=null)
          image(Im, Pos.x, Pos.y);
      } else
      {
        if (Transparent==false)
          rect(Pos.x, Pos.y, Rad*2, Height, Roundness);
        //if (Im!=null)
        //image(Im, Pos.x, Pos.y);
      }
    }



    if (Sqr==true)
    {
      if (Transparent==false)
        rect(Pos.x, Pos.y, Rad, Rad, Roundness);
      if (Im!=null)
        image(Im, Pos.x, Pos.y);
    }


    if (Circ==true)
    {

      if (Im!=null)
      {
        tint(255, alpha);
        if (Im==Player_Im&&MaxRad>=Player_Btn_Rad+2)
          image(Im, Pos.x, Pos.y, Rad, Rad);
        else
        {
          circle(Pos.x, Pos.y, Rad);
          image(Im, Pos.x, Pos.y);
        }
      } else
        circle(Pos.x, Pos.y, Rad);
    }


    if (S==null&&T==null)
      return;

    textMode(CENTER);
    if (Lerp_Color==false)
    {
      fill(255, alpha*2);
      if (Im==null&& ID!=6)
      {
        Im=Button_Im;
        this.Transparent=true;
      }
    } else
    {
      fill(0, alpha);
      if (Im==Button_Im && ID!=6)
      {
        Im=null;
        this.Transparent=false;
      }
    }
    tint(255, alpha*2);
    textSize(TextSize);
    text(S, Pos.x-S.length()*TextSize/4, Pos.y);



    if (Txt!=null)
    {
      for (int i =0; i<Txt.size(); i++)
      {
        fill(255, alpha);
        text(Txt.get(i), Pos.x+Rad*2, Pos.y+i*(TextSize*1.1));
      }
    } else 
    {
      fill(255, alpha);
      text(T, Pos.x+Rad*2, Pos.y);
    }


    noFill();
    noStroke();
    noTint();
  }

  //*lerp function(generic)
  //------------------------------------------------------------------------------------


  public float Lerp(float  Min, float Max, float speed)
  {

    float var = lerp(Min, Max, speed);
    return var;
  }

  //*return true of pressed , false if not
  //------------------------------------------------------------------------------------

  public boolean Pressed()
  {
    if (Pressable==false)
      return false;
    float w=0;
    float h=0;

    if (Circ==true||Sqr==true)
      w=h=Rad/2;
    if (Rect==true) {
      h=Rad/2/1.5;
      w=Rad;
    }


    if (mouseX<=Pos.x+ w &&mouseX>=Pos.x-w)
      if (mouseY<=Pos.y+h&mouseY>=Pos.y-h)
        return true;
    return false;
  }

  public float CalcAngle(Button B)
  {

    float angle=0;
    float dist= PVector.dist(this.Pos, B.Pos);
    float Dx = abs(this.Pos.x-B.Pos.x);
    angle = acos(Dx/dist);
    return angle;
  }

  public void ButtonAnimation()
  {
    if (this.alpha<=70)
      this.Lerp_Color=true;
  }
}
