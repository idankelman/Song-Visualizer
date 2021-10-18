import ketai.camera.*;
import ketai.cv.facedetector.*;
import ketai.data.*;
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;
import ketai.net.nfc.record.*;
import ketai.net.wifidirect.*;
import ketai.sensors.*;
import ketai.ui.*;


import g4p_controls.*;
import processing.sound.*;
import controlP5.*;
import javax.swing.*;
//import org.json.*;

//icon of the app
public PImage ICON ;
public PImage Tutorial;
public PImage Background ;
public PImage  Backward_Im;
public PImage  Forward_Im;
public PImage  Play_Im ;
public PImage  Player_Im;
public PImage Mask;

PGraphics maskImage;

public GTextArea txaArea; 
public SoundFile S;
public Playlist Playlist ;
public Playlist History;
public FFT fft;


final static String TITLE = "Song_Visualaizer Idan Kelman";
public JSONObject json;

public ArrayList<PImage> Footage;
public ArrayList<Button> Buttons;
public ArrayList<Button> Elements;
public PImage Help;
public PImage im;
public PImage V;
public PImage clock;
public PImage P;
public PImage M;
public PImage Button_Im;
public PImage Button_Im2;
public PImage Cover;
public PImage [] B;
public PImage [] B2;

public PFont Font;
public PImage Task_T;
public PImage Task;
public ControlP5 cp5;
public Textfield Text_Field; 


public boolean[] Keys;
public boolean help = false;

public final float Btn_rad = 50;
public final float Btn_rad2 = 60;
public final float Btn_rad3 = 40;
public final float Btn_rad4 = 100;
public final float Btn_rad5 = 20;
public float Player_Btn_Rad;
public float AutoSave=0;
public final float Expand = 120;
public float Amp = 0.4;

public Button Plus ;
public Button Minus;
public Button Actions;
public Button Player;
public Button Play;
public Button Forward;
public Button Backward;

public HScrollbar ScrollBar;
public int Project_Ind =0;
public int bands= 512;
public final color Bacground_C = color(255, 255, 255);
public final color ThemeA_1=#603430;
public final color ThemeA_2=#f8cfcd;
public final color ThemeB_1=#f8cfcd;
public final color ThemeB_2=#f8cfcd;

public float TextSize=12;
public String[] PreSave;
public boolean keyboard;
public int mouseW= 0;
public float Scroll = 40;



//======================================================================================= 
//*initialazing (setup)
//=======================================================================================

void settings() {
  //size(511, 1160);
  size(511, 1160);
  //size(displayWidth, displayHeight);
  // orientation(PORTRAIT);
  //size(511*2,850*2);
}


void setup()
{
  //2436-by-1125
  //size(1125,2436);
  //size(562, 1218,P2D);
  //size(562, 1218,P2D);
  //size(500, 500);
  //size(displayWidth,displayHeight);
  //orientation(PORTRAIT);


  Load();
  CreateSetup();
  CreateButtons(); 
  fft = new FFT(this, bands);
   changeAppIcon( ICON );
  changeAppTitle(TITLE);
}


//======================================================================================= 
//*main loop (update)
//=======================================================================================

void draw()
{
  background(Bacground_C);

  //this is the background for exe 
  //imageMode(CENTER);
  //image(Background,width/2,height/2);

  //this is the background for android apps 
  //imageMode(CORNER);


  imageMode(CENTER);
  image(Background, width/2, height/2);  

  PlayHistory();
 // Check_Bound();
  Show_Btn(Buttons);
  ShowCover();
  ScrollBar.display();
  ShowTime();
  Playlist.Show();
  autoPlay();
  SongVisualaize();
  AutoSave();
  Help();



  //Show(Elements);
}


//======================================================================================= 
//*psikot(interaptions)
//=======================================================================================

void mousePressed()
{
  Check(Buttons);
  //actiavate for android : using virtual keyboard
  //Check_Keyboard();
}

void keyPressed()
{
  println("KeyCode:"+keyCode);

  if (keyCode == ENTER&&Keys[0]==false&&Text_Field.isActive()&&Text_Field.getText()!="")
  {
    //Playlist.AddSong();
    //LoadSong();
    if (Playlist.Cover.equals("History"))
    {
      Playlist= new Playlist("New Playlist");
      S.stop();
      S=null;
      LoadCover(Playlist.Cover);
    }
    addSong();
    return;
  }

  if (keyCode==TAB)
  {

    Keys[5]=true;
    return;
  }

  if (keyCode==83)
  { 
    Keys[2]=true;
    return;
  }

  if (keyCode==72)
  { 
    Keys[4]=true;
    return;
  }

  if (keyCode==76)
  { 
    Keys[3]=true;
    return;
  }

  if (keyCode==CONTROL)   
  {
    Keys[0]=true;
    return;
  }

  if (keyCode==BACKSPACE)  
  {
    Keys[1]=true;  
    return;
  }

  if (keyCode == 70)
  {
    PrintArr("History", History.Urls, History.len);
  }

  if (keyCode ==71)
  {

    PrintArr("Save", PreSave, History.len);
  }


  //add new button;
}

void keyReleased()
{
  //if (keyCode==DELETE)          
  //Keys[1]=true;

  if (Keys[0]==true && Keys[3]==true)
  {
    Playlist = new Playlist("new");
    Playlist.LoadPlaylist();
  }

  //if (Keys[0]==true && Keys[1]==true)
  //DeleteProject();

  if (Keys[0]==true && Keys[2]==true)
    Playlist.SavePlaylist();

  if (Keys[0]==true && Keys[4]==true)
    help=!help;

  //if (Keys[0]==true && Keys[5]==true)
  //Exec11();


  for (int i =0; i<Keys.length; i++)
    Keys[i]=false;
}

void mouseWheel(MouseEvent event)
{
  mouseW = event.getCount();
  // Scroll();
  //update the current tasks height
  // A.Prev.y+=20*mouseW;
}
