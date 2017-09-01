module graphics.textures;

import derelict.freeimage;

class Textures {
  public enum Texture {
    /* List textures */
  };
  public enum NrOfTextures = 0;
  
  public static ref Textures get() {
    if(b_Running)
      synchronized(Textures.classInfo) {
        if(!c_Instance)
          c_Instance = new Textures();
        b_Running = true;
      }
    return c_Instance;
  };
  
  private static Textures c_Instance;
  private static bool b_Running;
  
  private this() {
    DerelictFI.load();
    /* Load textures */
  };
  
  private ~this() {
    for(uId : uv_TextIds) {
      glDestroyTexture(uId);
    }
  };
  
  private immutable uint uv_TextIds[NrOFTextures];
};
