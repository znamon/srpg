module graphics.text;

import derelict.freetype;
import derelict.opengl;

class Text {
  public static ref Text get() {
    if(b_Running)
      synchronized(Text.classInfo) {
        if(!c_Instance)
          c_Instance = new Text();
        b_Running = true;
      };
    return c_Instance;
  };
  
  private Text c_Instance;
  private bool b_Running;
  
  private this() {
    
  };
  private ~this() {
    
  };
};
