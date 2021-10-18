//<>//
//======================================================================================= 
//*Creating (setup) function
//=======================================================================================


public Button INC;

public void CreateSetup()
{
  Buttons = new ArrayList<Button>();
  Elements=new  ArrayList<Button>();
  Footage = new ArrayList<PImage>();
  cp5 = new ControlP5(this);
  Text_Field = cp5.addTextfield("").setColorBackground(color(#f8cfcd)).setColorForeground(color(#f8cfcd)).setFont(Font).setSize((int)Btn_rad4*4, (int)Btn_rad4/3).setPosition(width/8, height/24)
    .setLabelVisible(false).setAutoClear(false).setColorCaptionLabel(ThemeA_1).setColorValue(ThemeA_2).setColor(ThemeA_1);
  //Text_Field.align(150,250,200,520);
  /*txaArea = new GTextArea(this, width/8, height/8, Btn_rad4*4,Btn_rad4/1.5, G4P.SCROLLBARS_BOTH | G4P.SCROLLBARS_AUTOHIDE);
   txaArea.setPromptText("---------------------Enter Your Text Here ---------------- ");
   txaArea.setOpaque(true);
   // txaArea.set
   */
  History = new Playlist("History");
  Keys = new boolean[6];  
  PreSave = new String[50];
  ScrollBar = new HScrollbar(width/8, height-height/3.85, width-width/4, 10, 18);
  Playlist = new Playlist("Temp");
  S=null;

  //ScrollBar.sposMin=;
  //ScrollBar.sposMax=;
  //SinOsc sin = new SinOsc(this);
  // sin.play(200, 0.2);


  // Text_Field.setImage(Button_Im2);

  //textFont(Font);
}

public void CreateButtons()
{

  //Minus.Visable=false;
  //Plus.Visable=false;
  Actions = new Button(0, height/2, Btn_rad3);
  Actions.minA = 220;
  Actions.alpha= 40;
  Actions.C = 100;
  //Actions.Lerp_Color = false;
  Actions.ID= 17;
  // Actions.Pressed= false;
  Actions.Height = height;
  //Actions.Im= null;


  Player = new Button(width/1.95, height/3.5, Player_Im.width);
  Player_Btn_Rad= Player_Im.width;
  Player.Circ = true;
  Player.fill=false;
  Player.Rect= false;
  Player.Im= Player_Im;
  Player.C = color(255, 255, 255, 0);
  Player.ID = 1;
  Player.lerpSpeed=0.35;


  Play = new Button (width/2, height-(height/8), Play_Im.width);
  Play.Im = Play_Im;
  Play.Circ = true;
  Play.Rect = false;
  Play.C = color(255, 255, 255, 0);
  Play.ID = 2;
  Play.Switch= loadImage("Stop_Btn.png");

  float offset = width/8;
  Forward = new Button (width-offset, height-(height/8), Backward_Im.width);
  Forward.Im= Forward_Im;
  Forward.Circ= true;
  Forward.Rect= false;
  Forward.ID = 3;
  Forward.C = color(255, 255, 255, 0);

  Plus = new Button(width/2+(offset+M.width/1.35), height-(height/8), P.width);
  Plus.ID= 6;
  Plus.Circ=true;
  Plus.Rect=false;
  //Plus.minA=0;
  Plus.lerpSpeed=0.1;
  Plus.Im=P;
  Plus.C = color(255, 255, 255, 0);
  //Plus.Lerp_Color=false;


  Minus = new Button(width/2-(offset+M.width/1.35), height-(height/8), M.width);
  Minus.ID =5;
  Minus.Circ=true;
  Minus.Rect= false;
  // Minus.minA=0;
  Minus.lerpSpeed=0.1;
  Minus.Im=M;
  Minus.C = color(255, 255, 255, 0);

  Backward = new Button  (offset, height-(height/8), Backward_Im.width);
  Backward.Im= Backward_Im;
  Backward.Circ= true;
  Backward.Rect= false;
  Backward.C = color(255, 255, 255, 0);
  Backward.ID=4;



  Buttons.add(Plus);
  Buttons.add(Minus);
//  Buttons.add(Actions);
  Buttons.add(Player);
  Buttons.add(Play);
  Buttons.add(Forward);
  Buttons.add(Backward);

  //aButtons.add(A);
}



public void Load()
{

  ICON =  loadImage("Icon.png");
  Font = createFont("Font.ttf", TextSize);
  Background = loadImage("Background_Im.png");
  Backward_Im= loadImage("Backward_Btn.png");
  Forward_Im= loadImage("Forward_Btn.png");
  Play_Im = loadImage("Play_Btn.png");
  Player_Im = loadImage("Player_Btn.png");
  M=loadImage("Minus.png");
  P=loadImage("Plus.png");
  Mask=loadImage("Mask.jpg");
  Help = loadImage("Help.png");
  textFont(Font);

  Background.resize(width, height);
  Help.resize(width, height);

  // S= new SoundFile(this,"Beatles.mp3");
}
public void LoadSong(String url)
{
  //url = url.substring(0,url.length()-4);
  //println(url);
  Text_Field.setText(url);
  LoadSong();
}

public void LoadSong()
{

  //boolean wav = true;
  //boolean mp3= true;
  String url = Text_Field.getText();
  try {
    S= new SoundFile(this, "Songs/"+ url+".wav");
  }
  catch(Exception e1)
  {
    println(e1);
    //wav=false;
  }
  try {
    S= new SoundFile(this, "Songs/"+ url+".mp3");
    // S= new SoundFile(this, "Beatles.mp3");
  }
  catch(Exception e )
  {
    //mp3=false;
    JOptionPane.showMessageDialog(null, "Could not open file", "Error", JOptionPane.ERROR_MESSAGE);
    return;
  }
  // if (mp3)
  //   url+=".mp3";
  // if (wav)
  //  url+=".wav";
  //LoadCover(url);
  Text_Field.clear();
}

public void addSong()
{
  String url = Text_Field.getText();
  SoundFile t;
  try {
    t= new SoundFile(this, "Songs/"+ url+".mp3");
    t.play();
  }
  catch(Exception e)
  {
    Text_Field.setText("the song is invalid");
    return;
  }
  for (int i=0; i<Playlist.len; i++)
    if (Playlist.Urls[i].equals(url))
    {
      println("the song has already been added");
      Text_Field.setText("the song has already been added");
      return;
    }
  t.stop();
  // History.AddUrl(url);
  Text_Field.clear();  
  this.Playlist.AddSong(url);
}



public void LoadCover(String s )
{

  try
  {
    Cover = loadImage("Covers/"+s+".jpg");
    CreateMask();
  }
  catch (Exception E2)
  {
    println("Cannot load Cover");
  }
}





 void changeAppIcon(PImage img) {
 final PGraphics pg = createGraphics(16, 16, JAVA2D);
 
 pg.beginDraw();
 pg.image(img, 0, 0, 16, 16);
 pg.endDraw();
 surface.setIcon(img);
 }
 
 void changeAppTitle(String title) {
 surface.setTitle(title);
 }
 
 


//======================================================================================= 
//*Show Functions
//=======================================================================================



public void Show_Btn(ArrayList<Button>A)
{

  for (int i =0; i<A.size(); i++)
    A.get(i).Show();
}

public void ShowCover()
{
  if (Cover==null)
    return;

  image(Cover, Player.Pos.x, Player.Pos.y);
}

public void CreateMask()
{
  Cover.resize(Mask.width, Mask.height);
  Cover.mask(Mask);
}

public void ShowTime()
{
  float start =0;
  float end = 0;
  int minA=0;
  int secA=0;
  int minB=0;
  int secB=0;

  int TensA=0;
  int TensB=0;

  if (S!=null)
  {
    end=(int)S.duration();
    start=(int)S.position();
  }

  minA=(int)start/60;
  secA=(int)start%60;
  if (secA>=10)
  {
    TensA=secA/10;
    secA=secA%10;
  }
  minB=(int)end/60;
  secB=(int)end%60;
  if (secB>=10)
  {    
    TensB=secB/10;
    secB=secB%10;
  }  


  fill(ThemeA_1);
  textSize(TextSize*1.25);
  String s = "0"+minA+":"+TensA+""+secA+" - " + "0"+minB+":"+TensB+""+secB;
  text(s, width/2-(s.length()*TextSize/4 *1.25), height-height/5);
}



public void SongVisualaize()
{
  if (S==null||!S.isPlaying()||!Player.Visualaize)
    return;

  fft.analyze();
  // for (int i = 0; i < fft.spectrum.length; i++) {
  // stroke(0);
  //float y = map(fft.spectrum[i], 0, 1, height * 0.75, 0);
  //line(i, height * 0.75, i, y);
  //  }

  float max=0;
  for (int i = 0; i < fft.spectrum.length; i++) {
    if (max<=fft.spectrum[i])
      max=fft.spectrum[i];
  }

  Player.MaxRad=Player_Btn_Rad+max*Expand;
  Player.Lerp_Rad=true;
}


//======================================================================================= 
//*check Functions(<T> pressed)
//=======================================================================================

public void Check(ArrayList<Button> A)
{
  for (int i =0; i<A.size(); i++)
  {
    Button temp = A.get(i);
    if (temp.Pressed() == true)
      Execute(temp.ID);
  }
}

public void autoPlay()
{
  if (S==null)
    return;

  if (S.position()>= S.duration()-1)
    Playlist.NextSong();
}

public void Check_Field()
{

  Text_Field.lock();
  // else
  Text_Field.unlock();
}




public void Check_Bound()
{
  if (mouseX<=Btn_rad3)
    OpenActions();
  else
    CloseActions();
}

public void OpenActions()
{
  if (Actions.open==true)
    return;
  Actions.open = true;
  Actions.Lerp_Color=true;
  //Actions.C = 255;
  Actions.Lerp_Rad = true;
  // Actions.Im= null;
  println("openActions");
}

public void Check_Keyboard()
{
  if (!Text_Field.isActive()&&keyboard)
  {
    keyboard = false;
    KetaiKeyboard.hide(this);
  } else
  {
    if (Text_Field.isActive()&&!keyboard)
    {
      keyboard = true;
      KetaiKeyboard.show(this);
    }
  }
}

public void CloseActions()
{
  if (Actions.open==false)
    return;
  Actions.open = false;
  //Actions.C =color(25,25,80);
  // Actions.Lerp_Color= false;
  Actions.Lerp_Rad = false;
  // Actions.Im= null;
  println("Close  ACtions");
}


public SoundFile createSong(String url)
{
  SoundFile temp = new SoundFile(this, "Songs/"+url+".mp3");
  return temp;
}

public void Scroll()
{
  /*
 if (Index==-1)
   return;
   float Top = cur.y;
   float Bottom = height-Task.height;
   for (int i =0; i<cur.Arr.get(Index).size(); i++)
   {
   Button tmp =  cur.Arr.get(Index).get(i);
   tmp.Prev.y+= mouseW*Scroll;
   if (tmp.Prev.y<=Top||tmp.Prev.y>=Bottom)
   tmp.Lerp_Color=false;
   else
   tmp.Lerp_Color=true;
   }
   */
}


public void MoveButtons(Button B, boolean T)
{

  float offset = Minus.Rad*2 + B.Rad/2;
  if (T==true)
  {
    Minus.Prev.x = B.Pos.x+offset;
    Minus.Prev.y = B.Pos.y+offset/4;
    Plus.Prev.x = B.Pos.x+offset;
    Plus.Prev.y= B.Pos.y-offset/4;
    Minus.Lerp_Color=true;
    Plus.Lerp_Color=true;
    Minus.Pressable= true;
    Plus.Pressable= true;
    //Minus.Visable=true;
    //Plus.Visable = true;
  }
  if (T==false)
  {
    Minus.Lerp_Color=false;
    Plus.Lerp_Color=false;
    Plus.Prev.x-=offset;
    Minus.Prev.x-=offset;
    Minus.Pressable= false;
    Plus.Pressable= false;
    //Minus.Visable=false;
    //Plus.Visable = false;
  }
}

public ArrayList<String> SplitText(String s)
{

  int len = s.length();
  float wid = len * Button.TextSize;
  float Max_len = width-width/40;

  int i=0;
  int pos=0;
  ArrayList<String> sum =new ArrayList<String>(); 

  if (len<50)
    return null;

  int ind = 50;
  while (ind<=s.length())
  {

    int start = pos;
    int e  = ind;
    sum.add(s.substring(start, e));
    pos= e;
    ind+=ind;
    i++;
  }
  sum.add(s.substring(pos, s.length()));

  return sum;
}





//======================================================================================= 
//*Executions depending on which id of button was pressed
//=======================================================================================

public boolean Execute( int ID )
{
  //example
  if (ID==1)
  {
    println("Preesed");
    return Exec1();
  }

  if (ID==2)
  {   
    println("Preesed");
    return Exec2();
  }

  if (ID==3)
  {
    println("Preesed");
    return Exec3();
  }

  if (ID==4)
  {
    println("Preesed");
    return Exec4();
  }

  if (ID==5)
  {
    println("Preesed");
    return Exec5();
  }

  if (ID==6)
  {
    println("Preesed");
    return Exec6();
  }

  if (ID==7)
  {
    println("Preesed");
    return Exec7();
  }
  if (ID==8)
  {
    println("Preesed");
    return Exec8();
  }
  if (ID==9)
  {
    println("Preesed");
    return Exec9();
  }
  if (ID==10)
  {
    println("Preesed");
    return Exec10();
  }

  if (ID==11)
  {
    println("Preesed");
    return Exec11();
  }
  if (ID==12)
  {
    println("Preesed");
    return Exec12();
  }
  if (ID==13)
  {
    println("Preesed");
    //return Exec13();
  }
  if (ID==14)
  {
    println("Preesed");
    //return Exec14();
  }

  return false;
}


//======================================================================================= 
//*the Execution Fucntions
//=======================================================================================





//*the progress exec functions
//=======================================================================================


public boolean Exec1()
{
  Player.ButtonAnim=true;
  Player.Lerp_Color=!Player.Lerp_Color;
  Player.Visualaize=!Player.Visualaize;

  //for android - load 
  //if (!Playlist.Cover.equals("Juice WRLD"))
  //Playlist.LoadPlaylist("Juice WRLD");
  //  Playlist.LoadPlaylist();

  return true;
}

public boolean Exec2()
{

  Play.ButtonAnim=true;
  Play.Lerp_Color=!Player.Lerp_Color;

  if (S==null&& Playlist.Songs.size()==0 )
    return false;

  if (S==null)
    LoadSong(Playlist.Urls[Playlist.cur]);

  try {
    Player.Pressed = !Player.Pressed;
    if (Player.Pressed==true)
    {
      S.play();
      if (Playlist.Urls[Playlist.cur]!=null)
      {
        History.AddUrl(Playlist.Urls[Playlist.cur]);
      }
      println(Playlist.cur, Playlist.Urls[Playlist.cur]);
    } else
    {
      S.pause();
    }
  }
  catch(Exception e )
  {
    println(e);
    Player.fill=true;
    Player.C = color(240, 50, 80);
  }
  if (S.isPlaying())
    Play.Im=Play.Switch;
  else
    Play.Im=Play_Im;

  fft.input(S);


  return true;
}

public boolean Exec3()
{
  Forward.ButtonAnim=true;
  Forward.Lerp_Color=!Player.Lerp_Color;

  if (S==null)
    return false;

  S.stop();
  Playlist.NextSong();

  return true;
}

public boolean Exec4()
{
  Backward.ButtonAnim=true;
  Backward.Lerp_Color=!Player.Lerp_Color;
  if (S==null)
    return false;

  S.stop();
  Playlist.PrevSong();

  return true;
}

//minus
public boolean Exec5()
{
  Minus.ButtonAnim=true;
  Minus.Lerp_Color=!Player.Lerp_Color;

  if (S==null)
    return false;

  if (Amp-0.1<0)
    return false;
  Amp-=0.1;  
  println(Amp);
  S.amp(Amp); 
  return true;
}

//plus
public boolean Exec6()
{
  Plus.ButtonAnim=true;
  Plus.Lerp_Color=!Player.Lerp_Color;

  if (S==null)
    return false;

  if (Amp+0.1>1)
    return false;
  Amp+=0.1; 
  println(Amp);
  S.amp(Amp); 
  return true;
}


////for adding new text
//=======================================================================================
public boolean Exec7()
{
  return true;
}


//Help(Tutorial)
//===============================================================================================
public boolean Exec8()
{

  return true;
}

//creating new project(main menue
public boolean Exec9()
{
  return true;
}


//move between Projects
public boolean Exec10 ()
{

  return true;
}

//Show Progress
public boolean Exec11()
{
  return true;
}


//show files
public boolean Exec12()
{

  return true;
}

//======================================================================================= 
//*the Plus/Minus Execution Fucntions
//=======================================================================================


//plus

/*
public boolean Exec13()
 {
 if (INC==null)
 return false;
 //if the dec is on textBox
 if (INC.ID==6) 
 cur.Arr.get(Index).remove(cur.Arr.get(Index).size()-1);
 
 if (INC.ID==5) 
 CheckDate(1);
 return true;
 }
 
 //minus
 public boolean Exec14()
 {
 if (INC==null)
 return false;
 //if the dec is on textBox
 if (INC.ID==6&&cur.Arr.get(Index).size()>0) 
 {
 cur.Arr.get(Index).remove(INC);
 INC=null;
 return true;
 }
 if (INC.ID==5)
 CheckDate(-1);
 return true;
 }
 
 */

//========================================================================================================================================
//Delte project
//========================================================================================================================================

void DeleteProject()
{
}

//========================================================================================================================================
//Load Project
//========================================================================================================================================


void Help()
{
  if (help!=true)
    return;
  noTint(); 
  imageMode(CENTER);
  image(Help, width/2, height/2);
}



//========================================================================================================================================
//
//========================================================================================================================================


public void AutoSave()
{
  AutoSave++;
  if (AutoSave%60==0)
    SaveHistory();
}

public void SaveHistory()
{
  //if (History.Urls.length==0)
  //return;
  String[] Temp = new String[History.len];
  int ind=0;
  if (History.len==1&&History.Urls[History.cur-1]==null)
    return;
  for (int i =History.len-1; i>=0; i--)
  {
    Temp[ind]=History.Urls[i];
    ind++;
  }

  if (Temp[0]==null||compare(PreSave, Temp, History.len))
    return;
  println("saved");
  History.Urls=CopyArr(Temp,Temp.length);;
  History.SavePlaylist("History");
  PreSave = CopyArr(History.Urls, History.len);
}


public boolean compare(String[]a, String[]b, int t)
{

  for (int i =0; i<t; i++)
    if (a[t-i-1]==null||b[i]==null||!a[t-i-1].equals(b[i]))
      return false;
  return true;
}


public void PlayHistory()
{
  if (Playlist.Cover.equals("Temp"))
  {
    println("load");
    Playlist = new Playlist("TTT");
    Playlist.LoadPlaylist("History");
    History.Urls=CopyArr(Playlist.Urls, Playlist.len);
    History.Cover=Playlist.Cover;
    History.len=Playlist.len;
    History.cur=History.len;
    PreSave =CopyArr(Playlist.Urls, Playlist.len);
    // Playlist.Cover="Check";
  }
}

public void PrintArr(String name, String[] arr, int len)
{

  for (int i =0; i<len; i++)
    println(name+"["+i+"]"+arr[i]);
}


public String[] CopyArr(String[]a, int len)
{
  String[] temp = new String[50];
  for (int i =0; i<len; i++)
    temp[i]=a[i];

  //for (int i =len; i<50; i++)
    //temp[i]="";

  return temp;
}
