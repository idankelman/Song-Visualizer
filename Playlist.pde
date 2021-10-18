class Playlist
{
  public ArrayList<SoundFile> Songs;
  public String Cover ;
  public String[] Urls;
  public int len ;
  public int cur=-1;

  public Playlist(String Cover)
  {
    this.Songs = new ArrayList<SoundFile>();
    this.Cover = Cover;
    this.Urls = new String[20];
    len=0;
    cur= 0;
  }

  public Playlist(Playlist P)
  {
    this.Songs = P.Songs;
    this.Cover = P.Cover;
    this.Urls = P.Urls;
    len = P.len;
    cur = P.cur;
  }

  public void AddSong(String url)
  {

    SoundFile song = createSong(url);
    this.Songs.add(song);
    int pos = Songs.size()-1;
    Urls[pos] = url;
    len++;
  }



  public void AddUrl(String url)
  {
    println("the playlist:"+this.Cover);
    println("the url:"+url);
    for (int i =0; i<len; i++)
    {
      println(i);
      if (url.equals(this.Urls[i])==true)
      {
        println("found match at : " + i+" ,Going to shift left from :"+(len-1)+"to"+i);
        ShiftLeft(url, i);
        return;
      }
    }
    //int pos = Songs.size()-1;
    //Songs.add(song);
    println("adding a new song at : "+cur+"urls.len:"+Urls.length);
    this.Urls[cur] = url;
    this.len++;
    this.cur++;

    println("cur:"+cur+"Urls[cur]: "+Urls[cur-1]);
  }

  public void ShiftLeft(String url, int index)
  {
    for (int i =index; i<len-1; i++)
    {
      println("Index"+index);
      println("Index: "+index+" , Urls[i]:"+Urls[i]+"Urls[i+1]: "+Urls[i+1]);
      this.Urls[i]=this.Urls[i+1];
    }
    this.Urls[len-1]=url;
  }

  public void SavePlaylist(String name)
  {
    //save the urls,save the cover name , save the len;
    JSONObject save = new JSONObject();
    JSONArray URLS = new JSONArray();

    for (int i =0; i<this.len; i++)
    {
      URLS.setString(i, this.Urls[i]);
    }
    save.setJSONArray("Urls", URLS);
    save.setString("Cover", name);
    save.setInt("Len", this.len);
    saveJSONObject(save, "Playlists/"+name+".json");
  }

  public void LoadPlaylist()
  {
    final String id =JOptionPane.showInputDialog("Load Playlist :");
    if (id==null)
      return;

    println(id);
    LoadPlaylist(id);
  }

  public void SavePlaylist()
  {
    final String id =JOptionPane.showInputDialog("Save File_Name As:");
    if (id==null)
      return;

    println(id);
    SavePlaylist(id);
  }

  public void LoadPlaylist(String load)
  {
    //load the urls, load the cover name , load the len
    JSONObject json;
    //String in;
    //JSONObject reader = new JSONObject(in);
    try {
      json = loadJSONObject("Playlists/"+load+".json");
    }
    catch(Exception e )
    {
      println(e);
      //JOptionPane.showMessageDialog(null, "Could not open file", "Error", JOptionPane.ERROR_MESSAGE);
      return;
    }

    for (int i =0; i<this.len; i++)
      this.Urls[i]="";
    this.len= json.getInt("Len");
    this.Cover = json.getString("Cover");
    JSONArray arr = json.getJSONArray("Urls");
    for (int i =0; i<this.len; i++)
      this.Urls[i]=arr.getString(i);

    if (S!=null)
    {
      S.stop();
      S=null;
    }
    LoadCover(Cover);
    if (this.Urls[0]!=null)
      LoadSong(this.Urls[0]);
  }

  public void NextSong()
  {

    if (S==null) 
      return;

    S.stop(); 

    try {
      Player.Pressed=!Player.Pressed;
      S=Songs.get(cur+1);
      S.jump(0);
      S.stop();
      Exec2();
      cur++;
    }

    catch(Exception e)
    {
      if (cur+1>=len)
      {
        Player.Pressed=!Player.Pressed;
        println("No More Songs");
        return;
      }
      cur++;
      LoadSong(Urls[cur]);
      S.jump(0);
      S.stop();
      //S.play();
      Exec2();
    }

    //println(cur);
  }

  public void PrevSong()
  {
    if (S==null) 
      return;
    S.stop();  

    try {
      Player.Pressed=!Player.Pressed;
      S=Songs.get(cur-1);
      S.jump(0);
      S.stop();
      Exec2();
      cur--;
    }

    catch(Exception e) {
      if (cur-1<0)
      {
        Player.Pressed=!Player.Pressed;
        if (Player.Pressed==true)
        {
          S.jump(0);
          S.stop();
        }
        println("this is the last song");
        return;
      }
      cur--;
      LoadSong(Urls[cur]);
      S.stop();
      Exec2();
    }


    // println(cur);
  }

  public void Show()
  {
    textSize(TextSize*2);
    String Txt =Urls[cur];
    if (Txt!=null)
    {
      //Txt = Txt.substring(0,Txt.length()-4);
      text(Txt, width/2-(Txt.length()*TextSize/4.5*2.5), height-height/2.65);
    }
    textSize(TextSize*1.25);
    Txt = Cover;
    text(Txt, width/2-(Txt.length()*TextSize/4.5*1.5), height-height/2.9);

    textSize(TextSize);
    if (cur+1<=len)
    {
      Txt="The Next Song : ";
      Txt+=Urls[cur+1];

      text(Txt, width/2-(Txt.length()*TextSize/4.5), height-height/3.2);
    }
  }
}
